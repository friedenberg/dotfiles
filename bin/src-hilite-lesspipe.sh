#! /bin/sh -e

for source in "$@"; do
	CMD_SRC_HILITE="source-highlight --failsafe -f esc256 -i $source"
	case $source in

	*ChangeLog | *changelog)
		$CMD_SRC_HILITE --lang-def=changelog.lang
		;;

	*Makefile | *makefile)
		$CMD_SRC_HILITE --lang-def=makefile.lang
		;;

	*.tar | *.tgz | *.gz | *.bz2 | *.xz)
		lesspipe "$source"
		;;

	*)
		$CMD_SRC_HILITE --infer-lang
		;;
	esac
done
