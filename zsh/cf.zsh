# copies PCF env to local env!
function cf-copy-env () {
  [[ -z "$1" ]] && return 1;
  APP_GUID=$(cf app "${1}" --guid) || return 1;
  JSON_ENV="$(cf curl /v2/apps/${APP_GUID}/env)"
  # export VCAP_SERVICES=$(cf curl /v2/apps/${APP_GUID}/env | jq '.system_env_json.VCAP_SERVICES');
  export VCAP_SERVICES="$(jq '.system_env_json.VCAP_SERVICES' <<< ${JSON_ENV});"
  # export VCAP_APPLICATION=$(cf curl /v2/apps/${APP_GUID}/env | jq '.application_env_json.VCAP_APPLICATION');
  export VCAP_APPLICATION="$(jq '.application_env_json.VCAP_APPLICATION' <<< ${JSON_ENV});"
  # eval $(jq -r '.environment_json as $env | $env | keys | map("export \(.)=" + ($env[.] | @json | @sh)) | .[]' <<< ${JSON_ENV})
  eval "$(
    jq -r '.environment_json as $env
      | $env
      | keys
      | map("export \(.)=" + ($env[.] | @json))
      | .[]' <<< ${JSON_ENV}
  )"
  # export VCAP_APPLICATION=$(jq '.environment_json' <<< ${JSON_ENV});
}
