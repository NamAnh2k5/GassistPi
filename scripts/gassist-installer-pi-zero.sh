#!/bin/bash
# Copyright 2017 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -o errexit

scripts_dir="$(dirname "${BASH_SOURCE[0]}")"

# make sure we're running as the owner of the checkout directory
RUN_AS="$(ls -ld "$scripts_dir" | awk 'NR==1 {print $3}')"
if [ "$USER" != "$RUN_AS" ]
then
    echo "This script must run as $RUN_AS, trying to change user..."
    exec sudo -u $RUN_AS $0
fi

cd /home/pi/
sudo pip3 install mps-youtube youtube-dl
sudo apt-get install vlc -y
mpsyt set player vlc, set playerargs ,exit
sudo apt-get install elinks -y
sudo apt-get update -y
sudo apt-get install libttspico0 libttspico-utils libttspico-data -y
sudo apt-get install python3-dev python3-venv -y
python3 -m venv env
env/bin/python -m pip install --upgrade pip setuptools wheel
source env/bin/activate
sudo apt-get install portaudio19-dev libffi-dev libssl-dev
pip install RPi.GPIO
pip install pyaudio
pip install aftership
pip install feedparser
python -m pip install --upgrade google-assistant-sdk
python -m pip install --upgrade google-assistant-sdk[samples]
python -m pip install --upgrade google-auth-oauthlib[tool]
google-oauthlib-tool --client-secrets /home/pi/assistant.json --scope https://www.googleapis.com/auth/assistant-sdk-prototype --save --headless
