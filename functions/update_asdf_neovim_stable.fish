function update_asdf_neovim_stable --description 'Update asdf-neovim stable'
    echo "Update neovim (latest)stable!"
    asdf uninstall neovim stable
    asdf install neovim stable
end
