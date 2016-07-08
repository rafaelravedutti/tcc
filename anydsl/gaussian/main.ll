; ModuleID = 'main'
target datalayout = "e-p:64:64:64-S128-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f16:16:16-f32:32:32-f64:64:64-f128:128:128-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-unknown-linux-gnu"

%0 = type { [0 x i32]*, i32, i32 }

@0 = private unnamed_addr constant [17 x i8] c"lambda_crit_1733\00"
@1 = private unnamed_addr constant [8 x i8] c"main.cl\00"

define void @main() {
main_start:
  br label %main

main:                                             ; preds = %main_start
  %0 = call [0 x i32]* @allocate_image_data(i32 5, i32 10)
  br label %generate_image

generate_image:                                   ; preds = %main
  %allocate_image_data = phi [0 x i32]* [ %0, %main ]
  br label %while_head

while_head:                                       ; preds = %while_body, %generate_image
  %i = phi i32 [ %5, %while_body ], [ 0, %generate_image ]
  %1 = icmp slt i32 %i, 50
  br i1 %1, label %while_body, label %next

next:                                             ; preds = %while_head
  %2 = insertvalue %0 undef, [0 x i32]* %allocate_image_data, 0
  %3 = insertvalue %0 %2, i32 5, 1
  %4 = insertvalue %0 %3, i32 10, 2
  call void @apply_2d_convolution_1424(%0 %4, i32 3)
  br label %gaussian_blur

gaussian_blur:                                    ; preds = %next
  call void @print_image_data([0 x i32]* %allocate_image_data, i32 5, i32 10)
  br label %print_image

print_image:                                      ; preds = %gaussian_blur
  call void @free_image_data([0 x i32]* %allocate_image_data)
  br label %destroy_image

destroy_image:                                    ; preds = %print_image
  ret void

while_body:                                       ; preds = %while_head
  %5 = add nsw i32 1, %i
  %6 = getelementptr inbounds [0 x i32]* %allocate_image_data, i64 0, i32 %i
  %7 = srem i32 %i, 10
  store i32 %7, i32* %6
  br label %while_head
}

declare [0 x i32]* @allocate_image_data(i32, i32)

define internal void @apply_2d_convolution_1424(%0 %img_1426, i32 %mask_size_1427) {
apply_2d_convolution_1424_start:
  %0 = alloca i32
  %1 = alloca i32
  %anchor2 = alloca i32
  %2 = alloca i32
  br label %apply_2d_convolution

apply_2d_convolution:                             ; preds = %apply_2d_convolution_1424_start
  %3 = call i32 @device_get_id_1094()
  br label %_apply_2d_convolution

_apply_2d_convolution:                            ; preds = %apply_2d_convolution
  %dev_id = phi i32 [ %3, %apply_2d_convolution ]
  %4 = call { i32, i32, i32 } @device_get_2d_block_config_1106()
  %5 = extractvalue { i32, i32, i32 } %4, 0
  %6 = extractvalue { i32, i32, i32 } %4, 1
  %7 = extractvalue { i32, i32, i32 } %4, 2
  br label %_apply_2d_convolution1

_apply_2d_convolution1:                           ; preds = %_apply_2d_convolution
  %8 = phi i32 [ %5, %_apply_2d_convolution ]
  %9 = phi i32 [ %6, %_apply_2d_convolution ]
  %10 = phi i32 [ %7, %_apply_2d_convolution ]
  %11 = insertvalue { i32, i32, i32 } undef, i32 %8, 0
  %12 = insertvalue { i32, i32, i32 } %11, i32 %9, 1
  %13 = insertvalue { i32, i32, i32 } %12, i32 %10, 2
  %14 = extractvalue %0 %img_1426, 0
  %anchor = sdiv i32 %mask_size_1427, 2
  %15 = sub nsw i32 0, %anchor
  %16 = extractvalue %0 %img_1426, 2
  %17 = extractvalue %0 %img_1426, 1
  %18 = insertvalue { i32, i32, i32 } undef, i32 %17, 0
  %19 = insertvalue { i32, i32, i32 } %18, i32 %16, 1
  %20 = insertvalue { i32, i32, i32 } %19, i32 1, 2
  %21 = shl i32 %dev_id, 4
  %22 = or i32 2, %21
  call void @thorin_load_kernel(i32 %22, i8* getelementptr inbounds ([8 x i8]* @1, i32 0, i32 0), i8* getelementptr inbounds ([17 x i8]* @0, i32 0, i32 0))
  store i32 %16, i32* %2
  %23 = bitcast i32* %2 to i8*
  call void @thorin_set_kernel_arg(i32 %22, i32 0, i8* %23, i32 4)
  store i32 %anchor, i32* %anchor2
  %24 = bitcast i32* %anchor2 to i8*
  call void @thorin_set_kernel_arg(i32 %22, i32 1, i8* %24, i32 4)
  store i32 %15, i32* %1
  %25 = bitcast i32* %1 to i8*
  call void @thorin_set_kernel_arg(i32 %22, i32 2, i8* %25, i32 4)
  %26 = bitcast [0 x i32]* %14 to i8*
  call void @thorin_set_kernel_arg_ptr(i32 %22, i32 3, i8* %26)
  store i32 %17, i32* %0
  %27 = bitcast i32* %0 to i8*
  call void @thorin_set_kernel_arg(i32 %22, i32 4, i8* %27, i32 4)
  call void @thorin_set_grid_size(i32 %22, i32 %17, i32 %16, i32 1)
  call void @thorin_set_block_size(i32 %22, i32 %8, i32 %9, i32 %10)
  call void @thorin_launch_kernel(i32 %22)
  call void @thorin_synchronize(i32 %22)
  br label %acc_crit

acc_crit:                                         ; preds = %_apply_2d_convolution1
  ret void
}

declare void @print_image_data([0 x i32]*, i32, i32)

declare void @free_image_data([0 x i32]*)

define internal i32 @device_get_id_1094() {
device_get_id_1094_start:
  br label %device_get_id

device_get_id:                                    ; preds = %device_get_id_1094_start
  ret i32 0
}

define internal { i32, i32, i32 } @device_get_2d_block_config_1106() {
device_get_2d_block_config_1106_start:
  br label %device_get_2d_block_config

device_get_2d_block_config:                       ; preds = %device_get_2d_block_config_1106_start
  ret { i32, i32, i32 } { i32 32, i32 4, i32 1 }
}

declare void @thorin_load_kernel(i32, i8*, i8*)

declare void @thorin_set_kernel_arg(i32, i32, i8*, i32)

declare void @thorin_set_kernel_arg_ptr(i32, i32, i8*)

declare void @thorin_set_grid_size(i32, i32, i32, i32)

declare void @thorin_set_block_size(i32, i32, i32, i32)

declare void @thorin_launch_kernel(i32)

declare void @thorin_synchronize(i32)
