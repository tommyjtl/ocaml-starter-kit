open OUnit2
open Lib.Minty

let suite = "minty" >::: [
  "message" >:: (fun _ -> assert_equal ~cmp:String.equal "hello, world!" message);
]

let () = run_test_tt_main suite
