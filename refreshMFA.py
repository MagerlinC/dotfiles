#!/usr/bin/python3
import sys
import configparser
import json
import os
from os.path import expanduser
import subprocess
import re

mfaProfile = "mfa"
home = expanduser("~")
awsCred   = configparser.ConfigParser()
awsCred.read('%s/.aws/credentials' % home)

try:
    mfaARN = awsCred["default"]['mfa_serial']
except KeyError:
    exit("Need MFA serial in config file")

credentials = set( awsCred.sections())

if(mfaProfile in credentials):
    print("MFA profile already exist, updating")
else:
    awsCred.add_section(mfaProfile)

try:
    print("Please input TOTP")
    input = subprocess.run(["ykman","oath","accounts","code","cc-aws"], text=True, capture_output=True)
    digits = re.findall(r'\d+', input.stdout)
    digit = list(map(int, digits))
    OneTimeNumber = digit[0]
    print("TOTP read succesfully")
    #OneTimeNumber = int(os.system('ykman oath accounts code cc-aws | awk -F"cc-aws  " \'{print $2}\''))
    #OneTimeNumber = int(input("OTP from device: "))
except ValueError:
    exit("OTP must be a number")

response = os.popen("aws --profile %s sts get-session-token --serial-number  %s --token-code %s" % ( "default",
                                                                                                 mfaARN,
                                                                                                 str(OneTimeNumber).zfill(6))).read()

try:
    myjson = json.loads(response)
except json.decoder.JSONDecodeError:
    exit("AWS was not happy with that one")

awsCred[mfaProfile]['aws_access_key_id']     = myjson['Credentials']['AccessKeyId']
awsCred[mfaProfile]['aws_secret_access_key'] = myjson['Credentials']['SecretAccessKey']
awsCred[mfaProfile]['aws_session_token']     = myjson['Credentials']['SessionToken']

with open('%s/.aws/credentials' % home, 'w') as awsCredfile:
    awsCred.write(awsCredfile)

# print authenticated and some sparkles
print("✨ Authenticated ✨")
