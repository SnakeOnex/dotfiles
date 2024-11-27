alias o=xdg-open
alias vim=nvim
alias vi=nvim
alias po='papis open'

alias c='xclip -selection clipboard'
alias gpt='OPENAI_API_KEY=$CHATGPT_API_KEY python -m chatblade -s -i'
alias claude='OPENAI_API_KEY=$OPENROUTER_API_KEY python -m chatblade -i --openai-base-url https://openrouter.ai/api/v1/ --chat-gpt anthropic/claude-3-opus'
alias haiku='OPENAI_API_KEY=$OPENROUTER_API_KEY python -m chatblade -i --openai-base-url https://openrouter.ai/api/v1/ --chat-gpt anthropic/claude-3-haiku'
