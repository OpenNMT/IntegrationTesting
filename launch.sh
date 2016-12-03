# Command to login to ec2 and start job.
BOX=i-73ad3de6
KEY=../viz.pem
aws ec2 start-instances --instance-ids $BOX --region us-west-2
HOSTNAME=$(aws ec2 describe-instances --instance-ids $BOX --region us-west-2 | grep PublicIpAddress | awk -F ":" '{print $2}' | sed 's/[", ]//g')
echo $HOSTNAME;
echo ubuntu@$HOSTNAME
ssh -o "StrictHostKeyChecking no" -i $KEY ubuntu@$HOSTNAME 'export DATE=$(date "+%Y-%m-%d-%H-%M");cd IntegrationTesting;git pull -f origin master --no-edit; bash setup.sh;sudo nvidia-docker exec -i opennmt bash -c "$(cat run.sh)" | tee "logs/call_log_$DATE.txt";cat "logs/call_log_$DATE.txt" | python graph.py; git add "logs/call_log_$DATE.txt"; git commit -a -m .; git push origin master;exit'
aws ec2 stop-instances --instance-ids $BOX --region us-west-2
