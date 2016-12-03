#aws ec2 start-instances --instance-ids i-73ad3de6 --region us-west-2
HOSTNAME=$(aws ec2 describe-instances --instance-ids i-73ad3de6 --region us-west-2 | grep PublicIpAddress | awk -F ":" '{print $2}' | sed 's/[", ]//g')
echo $HOSTNAME;
echo ubuntu@$HOSTNAME
ssh -o "StrictHostKeyChecking no" -i viz.pem ubuntu@$HOSTNAME 'export DATE=$(date "+%Y-%m-%d-%H-%M");cd OpenNMT-Regression;bash setup.sh;sudo nvidia-docker exec -i opennmt bash -c "$(cat run.sh)" | tee "call_log_$DATE.txt";cat "call_log_$DATE.txt" | python graph.py; git add "call_log_$DATE.txt"; git commit -a -m .; git push origin master;exit'
aws ec2 stop-instances --instance-ids i-73ad3de6 --region us-west-2
