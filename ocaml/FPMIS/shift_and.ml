open Core
open Pervasives

open Utils

let find_mask c = List.find ~f:(fun (m, c') -> c == c')

let shift_and (pattern : string) (text : string) =
  let b = bitmask (String.to_list pattern) in
  let t = String.to_list text in
  let m = List.length b in
  let end_mask = (lsl) 1 m in

  let rec shift_and' d p text' =
    match List.nth text' 0 with
      | None -> Miss(pattern, text)
      | Some(c) ->
        let text'' = List.drop text' 1 in
        match find_mask c b with
        | Some((mask, _)) ->
            let d' = ((d lsl 1) lor 1) in
            let d'' = d' land mask in
            let is_hit = (d'' land end_mask) != 0 in
            if is_hit then Hit(pattern, text, Position(0, p))
            else
              let p' = if d == 0 then p+1 else p in
              shift_and' d'' p' text''
        | None -> shift_and' 0 (p+1) text''
  in

  shift_and' 0 0 t
