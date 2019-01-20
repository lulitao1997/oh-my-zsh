globalias() {
    local blacklist=(
        ls
        la
        l
        grep
        egrep
        fgrep
        cp
        df
        more
        open
    )

    if [[ ! -n "${blacklist[(r)$LBUFFER]}" ]]; then
        zle _expand_alias
        zle expand-word
    fi
    zle self-insert
}
zle -N globalias

# space expands all aliases, including global
bindkey -M emacs " " globalias
bindkey -M viins " " globalias

# control-space to make a normal space
bindkey -M emacs "^ " magic-space
bindkey -M viins "^ " magic-space

# normal space during searches
bindkey -M isearch " " magic-space
