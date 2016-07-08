; ModuleID = 'hello'
target datalayout = "e-p:64:64:64-S128-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f16:16:16-f32:32:32-f64:64:64-f128:128:128-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-unknown-linux-gnu"

define void @main() {
main_start:
  br label %main

main:                                             ; preds = %main_start
  %0 = call i32 @read_integer()
  br label %main1

main1:                                            ; preds = %main
  %read_integer = phi i32 [ %0, %main ]
  call void @print_integer(i32 %read_integer)
  br label %main2

main2:                                            ; preds = %main1
  ret void
}

declare i32 @read_integer()

declare void @print_integer(i32)
