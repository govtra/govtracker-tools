default:
	ocamlbuild -use-ocamlfind src/eo_parser.native

clean:
	ocamlbuild -clean
