import boto3
import os

def lambda_handler(event, context):
    region = os.environ['INSTANCE_REGION']
    ec2 = boto3.client('ec2', region_name=region)
    
    instances = ec2.describe_instances(Filters=[{'Name': 'instance-state-name', 'Values': ['running']}])
    for reservation in instances['Reservations']:
        for instance in reservation['Instances']:
            instance_id = instance['InstanceId']
            ec2.stop_instances(InstanceIds=[instance_id])
            print(f'Stopped instance: {instance_id}')
