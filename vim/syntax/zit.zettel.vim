
if exists("b:current_syntax")
  finish
endif

" TODO dynamically source syntax based on extension of akte
source $VIMRUNTIME/syntax/markdown.vim

" syn case match

syn region zitMetadatei start=/\v%^---$/ end=/\v^---$/ contains=zitMetadateiBezeichnungRegion,zitMetadateiEtikettRegion,zitMetadateiAkteRegion

syn match zitMetadateiBezeichnung /\v[^\n]+/ contained
syn match zitMetadateiBezeichnungPrefix /\v^# / contained nextgroup=zitMetadateiBezeichnung
syn region zitMetadateiBezeichnungRegion start=/\v^# / end=/$/ oneline contained contains=zitMetadateiBezeichnungPrefix,zitMetadateiBezeichnung

syn match zitMetadateiEtikett /\v[^\n]+/ contained contains=@NoSpell
syn match zitMetadateiEtikettPrefix /\v^- / contained
syn region zitMetadateiEtikettRegion start=/\v^- / end=/$/ oneline contained contains=zitMetadateiEtikett,zitMetadateiEtikettPrefix

syn match zitMetadateiAkteBase /\v[^\n]*\.@=/ contained contains=@NoSpell nextgroup=zitMetadateiAkteDot
syn match zitMetadateiAkteDot /\v\./ contained contains=@NoSpell nextgroup=zitMetadateiAkteExt
syn match zitMetadateiAkteExt /\v\w+/ contained contains=@NoSpell
syn match zitMetadateiAktePrefix /\v^! / contained nextgroup=zitMetadateiAkteBase
syn region zitMetadateiAkteRegion start=/\v^! / end=/$/ oneline contained contains=zitMetadateiAkte,zitMetadateiAktePrefix,zitMetadateiAkteBase,zitMetadateiAkteExt

" highlight default link zitLinePrefixRoot Special
highlight default link zitMetadatei Normal
highlight default link zitMetadateiBezeichnung Title
highlight default link zitMetadateiEtikett Constant
highlight default link zitMetadateiAkteBase Underlined
highlight default link zitMetadateiAkteExt Type

let b:current_syntax = 'zit.zettel'
