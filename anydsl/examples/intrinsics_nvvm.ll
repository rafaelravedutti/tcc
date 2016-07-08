; ModuleID = 'intrinsics_nvvm'
target datalayout = "e-p:64:64:64-S128-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f16:16:16-f32:32:32-f64:64:64-f128:128:128-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-unknown-linux-gnu"

%0 = type { [0 x float], i32, i32 }

@0 = global [9 x i8] c"lena.pgm\00"
@1 = private unnamed_addr constant [17 x i8] c"lambda_crit_2842\00"
@2 = private unnamed_addr constant [21 x i8] c"intrinsics_nvvm.nvvm\00"

define void @main() {
main_start:
  %0 = alloca i32
  %img3 = alloca %0
  br label %main

main:                                             ; preds = %main_start
  %out_2930 = alloca %0
  %1 = call %0 @read_image([0 x i8]* bitcast ([9 x i8]* @0 to [0 x i8]*))
  br label %main1

main1:                                            ; preds = %main
  %img = phi %0 [ %1, %main ]
  %2 = getelementptr inbounds %0* %out_2930, i32 0, i32 0
  %3 = extractvalue %0 %img, 1
  %4 = extractvalue %0 %img, 2
  %5 = mul nsw i32 %3, %4
  %6 = insertvalue { i32, i32, i32 } undef, i32 %3, 0
  %7 = insertvalue { i32, i32, i32 } %6, i32 %4, 1
  %8 = insertvalue { i32, i32, i32 } %7, i32 1, 2
  %9 = insertvalue %0 undef, i32 %3, 1
  %10 = insertvalue %0 %9, i32 %4, 2
  store %0 %10, %0* %out_2930
  call void @thorin_load_kernel(i32 1, i8* getelementptr inbounds ([21 x i8]* @2, i32 0, i32 0), i8* getelementptr inbounds ([17 x i8]* @1, i32 0, i32 0))
  store %0 %img, %0* %img3
  %11 = bitcast %0* %img3 to i8*
  call void @thorin_set_kernel_arg_struct(i32 1, i32 0, i8* %11, i32 8)
  %12 = bitcast [0 x float]* %2 to i8*
  call void @thorin_set_kernel_arg_ptr(i32 1, i32 1, i8* %12)
  store i32 %3, i32* %0
  %13 = bitcast i32* %0 to i8*
  call void @thorin_set_kernel_arg(i32 1, i32 2, i8* %13, i32 4)
  call void @thorin_set_grid_size(i32 1, i32 %3, i32 %4, i32 1)
  call void @thorin_set_block_size(i32 1, i32 32, i32 4, i32 1)
  call void @thorin_launch_kernel(i32 1)
  call void @thorin_synchronize(i32 1)
  br label %field_indices_crit

field_indices_crit:                               ; preds = %main1
  %14 = load %0* %out_2930
  call void @show_image(%0 %14)
  br label %main2

main2:                                            ; preds = %field_indices_crit
  ret void
}

declare %0 @read_image([0 x i8]*)

declare void @thorin_load_kernel(i32, i8*, i8*)

declare void @thorin_set_kernel_arg_struct(i32, i32, i8*, i32)

declare void @thorin_set_kernel_arg_ptr(i32, i32, i8*)

declare void @thorin_set_kernel_arg(i32, i32, i8*, i32)

declare void @thorin_set_grid_size(i32, i32, i32, i32)

declare void @thorin_set_block_size(i32, i32, i32, i32)

declare void @thorin_launch_kernel(i32)

declare void @thorin_synchronize(i32)

declare void @show_image(%0)
