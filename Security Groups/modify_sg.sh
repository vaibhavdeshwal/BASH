#!/bin/bash

options=("Show existing rules of security groups." "Add new inbound/outbound rules on security groups." "Revoke inbound/outbound rules of security groups." "Quit")
PS3="Select an option: "

select opt in "${options[@]}"
do
    case $opt in
        "Show existing rules of security groups.")
            echo -e "\nYou selected option 1.\n"
            # Set the security group id
            read -p "my-security-group id: " sg_id

            # Describe the security group
            sg_description=$(aws ec2 describe-security-groups --group-id $sg_id)

            # Extract the inbound and outbound rules from the security group description
            inbound_rules=$(echo $sg_description | jq '.SecurityGroups[].IpPermissions')
            outbound_rules=$(echo $sg_description | jq '.SecurityGroups[].IpPermissionsEgress')

            # Print the inbound rules
            echo "Inbound Rules:"
            echo $inbound_rules | jq '.'

            # Print the outbound rules
            echo "Outbound Rules:"
            echo $outbound_rules | jq '.'

            ;;
        "Add new inbound/outbound rules on security groups.")
            echo -e "\nYou selected option 2.\n"
            # Set the security group and rule parameters
            read -p "Enter Security Group id: " sg_id

            # Set the inbound rule parameters
            read -p "Enter Inbound protocol: (e.g. -- tcp|udp|icmp|all ): " INBOUND_PROTOCOL
            read -p "Enter Inbound port: (e.g. -- 80,443,22 ): " INBOUND_PORT
            read -p "Enter Inbound CIDR IP: (e.g. -- 0.0.0.0/0 : " INBOUND_CIDR
            sleep 1

            # Set the outbound rule parameters
            echo -e "\nSet the outbound rule parameters\n"
            sleep 1
            read -p "Enter Outbound protocol: " OUTBOUND_PROTOCOL
            read -p "Enter Outbound port : " OUTBOUND_PORT
            read -p "Enter Outbound CIDR: " OUTBOUND_CIDR

            # Add the inbound and outbound rules to the security group
            aws ec2 authorize-security-group-ingress --group-id $sg_id --protocol $INBOUND_PROTOCOL --port $INBOUND_PORT --cidr $INBOUND_CIDR
            aws ec2 authorize-security-group-egress --group-id $sg_id --protocol $OUTBOUND_PROTOCOL --port $OUTBOUND_PORT --cidr $OUTBOUND_CIDR

            ;;
        "Revoke inbound/outbound rules of security groups.")
            echo -e "\nYou selected option 3.\n"
            # Set the security group ID
            read -p "Enter Security group id: " sg_id

            # Set the inbound rule parameters
            read -p "Enter Inbound protocol: (e.g. -- tcp|udp|icmp|all ): " INBOUND_PROTOCOL
            read -p "Enter Inbound port: (e.g. -- 80,443,22 ): " INBOUND_PORT
            read -p "Enter Inbound CIDR IP: (e.g. -- 0.0.0.0/0 : " INBOUND_CIDR
            sleep 1
            # Set the outbound rule parameters
            echo -e "\nSet the outbound rule parameters\n"
            sleep 1
            
            read -p "Enter Outbound protocol: " OUTBOUND_PROTOCOL
            read -p "Enter Outbound port : " OUTBOUND_PORT
            read -p "Enter Outbound CIDR: " OUTBOUND_CIDR

            # Remove all inbound rules
            aws ec2 revoke-security-group-ingress --group-id $sg_id --protocol $INBOUND_PROTOCOL --port $INBOUND_PORT --cidr $INBOUND_CIDR

            # Remove all outbound rules
            aws ec2 revoke-security-group-egress --group-id $sg_id --protocol $OUTBOUND_PROTOCOL --port $OUTBOUND_PORT --cidr $OUTBOUND_CIDR
            ;;
        "Quit")
            break
            ;;
        *) echo -e "\nInvalid option, try again.\n";;
    esac
done
