#!/bin/bash
set -e

source $(dirname $0)/helpers.sh

export src=$(mktemp -d /tmp/in-src.XXXXXX)

# set FILE_URL_WITH_LAST_MODIFIED_INFO with a URL of a file whose HTTP HEADER info provides a Last-Modified entry
# to check it do "curl -I -R <url>"
export FILE_URL_WITH_LAST_MODIFIED_INFO=https://s3-us-west-1.amazonaws.com/lsilva-bpws/PCF_usage/pcf-sandbox-usage-from-2016-09-01-to-2016-09-30_1475771124.json
export FILE_NAME_1=pcf-sandbox.json
# set FILE_URL_WITHOUT_LAST_MODIFIED_INFO with a URL of a file whose HTTP HEADER info DOES NOT provide a Last-Modified entry
# to check it do "curl -I -R <url>"
export FILE_URL_WITHOUT_LAST_MODIFIED_INFO=https://raw.githubusercontent.com/pivotalservices/concourse-curl-resource/master/test/data/pivotal-1.0.0.txt
export FILE_NAME_2=ivotal-1.0.0.txt
# set FILE_URL_BASIC_AUTH with a URL of a file that requires basic authentication
export FILE_URL_BASIC_AUTH=https://auth-demo.aerobatic.io/protected-standard

it_can_get_file_with_date_info() {
  jq -n "{
    source: {
      url: $(echo $FILE_URL_WITH_LAST_MODIFIED_INFO | jq -R .),
      filename: $(echo $FILE_NAME_1 | jq -R .)
    }
  }" | $resource_dir/in "$src" | tee /dev/stderr

}

it_can_get_file_with_basic_auth() {

  echo "Source=[$src]"

  jq -n "{
    source: {
      url: $(echo $FILE_URL_BASIC_AUTH | jq -R .),
      username: $(echo 'aerobatic' | jq -R .),
      password: $(echo 'aerobatic' | jq -R .),
      filename: $(echo 'basicauth.txt' | jq -R .)
    }
  }" | $resource_dir/in "$src" | tee /dev/stderr

  # cat "$src"/basicauth.txt | grep expect 
  # should return "...Hi, we've been expecting you!..."

}

run it_can_get_file_with_date_info
run it_can_get_file_with_basic_auth
