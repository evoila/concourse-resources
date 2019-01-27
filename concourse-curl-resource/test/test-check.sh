#!/bin/bash

set -e

source $(dirname $0)/helpers.sh

# set FILE_URL_WITH_LAST_MODIFIED_INFO with a URL of a file whose HTTP HEADER info provides a Last-Modified entry
# to check it do "curl -I -R <url>"
export FILE_URL_WITH_LAST_MODIFIED_INFO=https://s3-us-west-1.amazonaws.com/lsilva-bpws/PCF_usage/pcf-sandbox-usage-from-2016-09-01-to-2016-09-30_1475771124.json
# set FILE_URL_WITHOUT_LAST_MODIFIED_INFO with a URL of a file whose HTTP HEADER info DOES NOT provide a Last-Modified entry
# to check it do "curl -I -R <url>"
export FILE_URL_WITHOUT_LAST_MODIFIED_INFO=https://raw.githubusercontent.com/pivotalservices/concourse-curl-resource/master/test/data/pivotal-1.0.0.txt
# set FILE_URL_BASIC_AUTH with a URL of a file that requires basic authentication
export FILE_URL_BASIC_AUTH=https://auth-demo.aerobatic.io/protected-standard

it_can_get_file_with_last_modified_info() {

  echo $resource_dir

  jq -n "{
    source: {
      url: $(echo $FILE_URL_WITH_LAST_MODIFIED_INFO | jq -R .)
    }
  }" | $resource_dir/check "$FILE_URL_WITH_LAST_MODIFIED_INFO" | tee /dev/stderr

}

it_can_get_file_without_last_modified_info() {

  jq -n "{
    source: {
      url: $(echo $FILE_URL_WITHOUT_LAST_MODIFIED_INFO | jq -R .)
    }
  }" | $resource_dir/check "$FILE_URL_WITHOUT_LAST_MODIFIED_INFO" | tee /dev/stderr

}

it_can_get_file_with_basic_auth() {

  echo $resource_dir

  jq -n "{
    source: {
      url: $(echo $FILE_URL_BASIC_AUTH | jq -R .),
      username: $(echo 'aerobatic' | jq -R .),
      password: $(echo 'aerobatic' | jq -R .),
      filename: $(echo 'basicauth.txt' | jq -R .)
    }
  }" | $resource_dir/check "$FILE_URL_BASIC_AUTH" | tee /dev/stderr

}

run it_can_get_file_with_last_modified_info
run it_can_get_file_without_last_modified_info
run it_can_get_file_with_basic_auth
