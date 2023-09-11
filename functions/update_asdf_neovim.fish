function update_asdf_neovim --description "Update asdf-neovim"
    set product_version 0.1.0
    set product_name "update_asdf_neovim"

    function __help_message
        echo "$product_name(fish)"
        echo "Update asdf-neovim tools"
        echo ""
        echo "Usage:"
        echo "    $product_name <COMMAND> <SUBCOMMANDS>"
        echo ""
        echo "Commands:"
        echo "  master            Run update_asdf_neovim_master"
        echo "  stable            Run update_asdf_neovim_stable"
        echo "  nightly           Run update_asdf_neovim_nightly"
        echo ""
        echo "Options:"
        echo "    --version, -v, version    print $product_name version"
        echo "    --help, -h, help          print this help"
    end

    function __master
        echo "Update neovim (latest)master!"
        asdf uninstall neovim ref:master
        asdf install neovim ref:master
    end

    function __nightly
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

    function __stable
        set VERSION (nvim --version | head -n 1 | string split ' ' | sed -n '2p')
        set NEW_VERSION (curl --silent https://api.github.com/repos/neovim/neovim/releases/tags/nightly | jq .body | string split ' ' | string split '\n' | sed -n '3p' | sed -e "s/%0ABuild//g")
        if test $VERSION != $NEW_VERSION
            echo "Update neovim (latest)stable!"
            asdf uninstall neovim stable
            asdf install neovim stable
        else
            echo "neovim (latest)nightly is already installed"
            echo "version: $VERSION"
        end
    end

    switch "$cmd"
        case -v --version version
            echo "$product_name(fish) v$product_version"
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
