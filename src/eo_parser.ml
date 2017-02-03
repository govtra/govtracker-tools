open Yojson.Basic.Util

let write_entry json pres =
    let title = json |> member "title" |> to_string in
    let date = json |> member "signing_date" |> to_string in
    let pdflink = json |> member "pdf_url" |> to_string in
    let content = String.concat "" [
        "**["; pres;
        "](https://en.wikipedia.org/wiki/President_of_the_United_States)** ";
        "signed an executive order entitled _"; title; "_ / **[source](";
        pdflink; ")"] in
    let fname = String.concat "" [date; ".md"] in
    let oc = open_out fname in
    Printf.fprintf oc "%s" content;
    close_out oc

let rec parse_edata pres = function
    | [] -> ()
    | a::l -> write_entry a pres; parse_edata pres l

let main () = 
    let json = Yojson.Basic.from_file Sys.argv.(1) in
    let eos_data = json |> member "results" |> to_list in
    let descr = json |> member "description" |> to_string in
    let pres = String.split_on_char ',' (String.sub descr 20 50) |> List.hd in
    parse_edata pres eos_data

let () =
    main ()
