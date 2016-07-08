; ModuleID = 'utils.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }

@stdout = external global %struct._IO_FILE*
@.str = private unnamed_addr constant [4 x i8] c"%d \00", align 1
@.str1 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32* @allocate_image_data(i32 %width, i32 %height) #0 {
entry:
  %retval = alloca i32*, align 8
  %width.addr = alloca i32, align 4
  %height.addr = alloca i32, align 4
  store i32 %width, i32* %width.addr, align 4
  store i32 %height, i32* %height.addr, align 4
  %0 = load i32* %width.addr, align 4
  %cmp = icmp sgt i32 %0, 0
  br i1 %cmp, label %land.lhs.true, label %if.end

land.lhs.true:                                    ; preds = %entry
  %1 = load i32* %height.addr, align 4
  %cmp1 = icmp sgt i32 %1, 0
  br i1 %cmp1, label %if.then, label %if.end

if.then:                                          ; preds = %land.lhs.true
  %2 = load i32* %width.addr, align 4
  %3 = load i32* %height.addr, align 4
  %mul = mul nsw i32 %2, %3
  %conv = sext i32 %mul to i64
  %mul2 = mul i64 %conv, 4
  %call = call noalias i8* @malloc(i64 %mul2) #3
  %4 = bitcast i8* %call to i32*
  store i32* %4, i32** %retval
  br label %return

if.end:                                           ; preds = %land.lhs.true, %entry
  store i32* null, i32** %retval
  br label %return

return:                                           ; preds = %if.end, %if.then
  %5 = load i32** %retval
  ret i32* %5
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #1

; Function Attrs: nounwind uwtable
define void @free_image_data(i32* %data) #0 {
entry:
  %data.addr = alloca i32*, align 8
  store i32* %data, i32** %data.addr, align 8
  %0 = load i32** %data.addr, align 8
  %1 = bitcast i32* %0 to i8*
  call void @free(i8* %1) #3
  ret void
}

; Function Attrs: nounwind
declare void @free(i8*) #1

; Function Attrs: nounwind uwtable
define void @print_image_data(i32* %data, i32 %width, i32 %height) #0 {
entry:
  %data.addr = alloca i32*, align 8
  %width.addr = alloca i32, align 4
  %height.addr = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store i32* %data, i32** %data.addr, align 8
  store i32 %width, i32* %width.addr, align 4
  store i32 %height, i32* %height.addr, align 4
  store i32 0, i32* %j, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc5, %entry
  %0 = load i32* %j, align 4
  %1 = load i32* %height.addr, align 4
  %cmp = icmp ult i32 %0, %1
  br i1 %cmp, label %for.body, label %for.end7

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %i, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc, %for.body
  %2 = load i32* %i, align 4
  %3 = load i32* %width.addr, align 4
  %cmp2 = icmp ult i32 %2, %3
  br i1 %cmp2, label %for.body3, label %for.end

for.body3:                                        ; preds = %for.cond1
  %4 = load %struct._IO_FILE** @stdout, align 8
  %5 = load i32* %j, align 4
  %6 = load i32* %width.addr, align 4
  %mul = mul i32 %5, %6
  %7 = load i32* %i, align 4
  %add = add i32 %mul, %7
  %idxprom = zext i32 %add to i64
  %8 = load i32** %data.addr, align 8
  %arrayidx = getelementptr inbounds i32* %8, i64 %idxprom
  %9 = load i32* %arrayidx, align 4
  %call = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %4, i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %9)
  br label %for.inc

for.inc:                                          ; preds = %for.body3
  %10 = load i32* %i, align 4
  %inc = add i32 %10, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond1

for.end:                                          ; preds = %for.cond1
  %11 = load %struct._IO_FILE** @stdout, align 8
  %call4 = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %11, i8* getelementptr inbounds ([2 x i8]* @.str1, i32 0, i32 0))
  br label %for.inc5

for.inc5:                                         ; preds = %for.end
  %12 = load i32* %j, align 4
  %inc6 = add i32 %12, 1
  store i32 %inc6, i32* %j, align 4
  br label %for.cond

for.end7:                                         ; preds = %for.cond
  ret void
}

declare i32 @fprintf(%struct._IO_FILE*, i8*, ...) #2

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.6.2 (branches/release_36 262196)"}
