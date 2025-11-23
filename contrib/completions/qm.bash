#!/usr/bin/env bash
# Bash completion for `qm`
# Place this file in /etc/bash_completion.d/ or source it from your shell.

_qm() {
    local cur prev words cword cmd
    _get_comp_words_by_ref 2>/dev/null || true
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    cmd="${COMP_WORDS[1]:-}"

    local subcommands="install remove list status"
    local global_opts="-r --rootful -h --help"

    # complete top-level subcommands
    if [[ ${COMP_CWORD} -eq 1 ]]; then
        COMPREPLY=( $(compgen -W "$subcommands" -- "$cur") )
        return 0
    fi

    case "$cmd" in
        install|remove|status)
            # allow flags first
            if [[ "$cur" == -* ]]; then
                COMPREPLY=( $(compgen -W "$global_opts" -- "$cur") )
                return 0
            fi

            # suggest quadlet names found next to the installed `qm` script
            local qm_path dir names=()
            qm_path=$(command -v qm 2>/dev/null || true)
            if [[ -n "$qm_path" ]]; then
                dir=$(dirname "$(readlink -f "$qm_path")")
                if [[ -d "$dir" ]]; then
                    for d in "$dir"/*; do
                        [[ -d "$d" ]] || continue
                        names+=("$(basename "$d")")
                    done
                fi
            fi
            if [[ ${#names[@]} -gt 0 ]]; then
                COMPREPLY=( $(compgen -W "${names[*]}" -- "$cur") )
            fi
            ;;
        list)
            if [[ "$cur" == -* ]]; then
                COMPREPLY=( $(compgen -W "-h --help" -- "$cur") )
            fi
            ;;
        *)
            ;;
    esac
}

complete -F _qm qm
