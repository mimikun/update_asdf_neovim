function update_asdf_neovim_nightly --description 'Update asdf-neovim nightly'
    set OLD_VERSION (nvim --version | head -n 1 | string split ' ' | sed -n '2p')
    set VERSION (curl --silent https://api.github.com/repos/neovim/neovim/releases/tags/nightly | jq .body | string split ' ' | string split '\n' | sed -n '3p')
    if test $OLD_VERSION != $VERSION
        asdf uninstall neovim nightly
        asdf install neovim nightly
    end
end
