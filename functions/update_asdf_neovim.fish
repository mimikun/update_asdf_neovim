function update_asdf_neovim --description "Update asdf-neovim"
    set -l product_version 0.2.0
    set -l product_name "update_asdf_neovim"

    function __help_message
        echo $product_name"(fish)"
        echo "Update asdf-neovim"
        echo ""
        echo "Usage:"
        echo "    $product_name <COMMAND>"
        echo ""
        echo "Commands:"
        echo "  master                  Run update asdf neovim master"
        echo "  stable                  Run update asdf neovim stable"
        echo "  nightly                 Run update asdf neovim nightly"
        echo ""
        echo "Options:"
        echo "    --version, -v, version    print $product_name version"
        echo "    --help, -h, help          print this help"
    end

    function __version
        echo "$product_name(fish) v$product_version"
    end

    function __master
        set -l neovim_master_commit_hash_file $HOME/.cache/neovim-master-commit-hash.txt
        set -l master_commit_hash (cat $neovim_master_commit_hash_file)
        set -l master_new_commit_hash (git ls-remote --heads --tags https://github.com/neovim/neovim.git | grep refs/heads/master | cut -f 1)

        if test $master_commit_hash != $master_new_commit_hash
            echo "neovim (latest)master found!"
            echo $master_new_commit_hash >$neovim_master_commit_hash_file
            asdf uninstall neovim ref:master
            asdf install neovim ref:master
        else
            echo "neovim (latest)master is already installed"
            echo "commit hash: $master_commit_hash"
        end
    end

    function __nightly
        set -l nvim_nightly_version (nvim --version | head -n 1 | tr " " "\n" | sed -n '2p')
        set -l nvim_nightly_new_version (curl --silent https://api.github.com/repos/neovim/neovim/releases/tags/nightly | jq .body | tr " " "\n" | sed -n 2p | sed -e "s/\\\nBuild//g")

        if test $nvim_nightly_version != $nvim_nightly_new_version
            echo "neovim (latest)nightly found!"
            asdf uninstall neovim nightly
            asdf install neovim nightly
        else
            echo "neovim (latest)nightly is already installed"
            echo "version: $nvim_nightly_version"
        end
    end

    function __stable
        set -l nvim_stable_version ("$ASDF_DIR/installs/neovim/stable/bin/nvim" --version | head -n 1 | tr " " "\n" | sed -n '2p')
        set -l nvim_stable_new_version (curl --silent https://api.github.com/repos/neovim/neovim/releases/tags/stable | jq .body | tr " " "\n" | sed -n 2p | sed -e "s/\\\nBuild//g")

        if test $nvim_stable_version != $nvim_stable_new_version
            echo "Update neovim (latest)stable!"
            asdf uninstall neovim stable
            asdf install neovim stable
        else
            echo "neovim (latest)nightly is already installed"
            echo "version: $nvim_stable_version"
        end
    end

    switch "$cmd"
        case -v --version version
            __version
        case "" -h --help help
            __help_message
        case master
            __master
        case stable
            __stable
        case nightly
            __nightly
        case \*
            echo "$product_name: Unknown command: \"$cmd\"" >&2 && return 1
    end
end
