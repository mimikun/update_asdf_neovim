function update_asdf_neovim_nightly --description 'Update asdf-neovim nightly'
    set VERSION (nvim --version | head -n 1 | string split ' ' | sed -n '2p')
    set NEW_VERSION (curl --silent https://api.github.com/repos/neovim/neovim/releases/tags/nightly | jq .body | string split ' ' | string split '\n' | sed -n '3p' | sed -e "s/%0ABuild//g")
    if test $VERSION != $NEW_VERSION
        echo "neovim (latest)nightly found!"
        asdf uninstall neovim nightly
        asdf install neovim nightly
    else
        echo "neovim (latest)nightly is already installed"
        echo "version: $VERSION"
    end
end
