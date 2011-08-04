# lib/underscore.sh
# [[ -z "$UNDERSCORE_DELIM" ]] && UNDERSCORE_DELIM="=="
# [[ -z "$UNDERSCORE_LOG_DIR" ]] && UNDERSCORE_LOG_DIR=/var/tmp
# 
# _() {
# 
#   ruby -e 'puts File.read(ARGV[0]).split("\n#{ARGV[1]}")[-2]' \
#     "$UNDERSCORE_LOG_FILE" "$UNDERSCORE_DELIM"
# }
# 
# underscore_prompt_command() {
#   echo -n "$UNDERSCORE_DELIM" >> "$UNDERSCORE_LOG_FILE"
#   [[ -n "$UNDERSCORE_OLD_PROMPT_COMMAND" ]] && eval "$UNDERSCORE_OLD_PROMPT_COMMAND"
# }
# 
# UNDERSCORE_OLD_PROMPT_COMMAND="$PROMPT_COMMAND"
# export PROMPT_COMMAND=underscore_prompt_command
