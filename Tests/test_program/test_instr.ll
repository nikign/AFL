; ModuleID = 'Tests/test_program/test_instr.c_1.o.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, %struct._IO_codecvt*, %struct._IO_wide_data*, %struct._IO_FILE*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type opaque
%struct._IO_codecvt = type opaque
%struct._IO_wide_data = type opaque

@.str = private unnamed_addr constant [2 x i8] c"r\00", align 1
@str.6 = private unnamed_addr constant [5 x i8] c"Hum?\00", align 1
@str.5 = private unnamed_addr constant [25 x i8] c"Looks like a zero to me!\00", align 1
@str = private unnamed_addr constant [30 x i8] c"A non-zero value? How quaint!\00", align 1
@.str.4 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@__bb_coverage_ptr = external global i64*

; Function Attrs: noreturn nounwind uwtable
define dso_local i32 @main(i32, i8** nocapture readonly) local_unnamed_addr #0 {
  %3 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %4 = getelementptr i64, i64* %3, i64 1
  %5 = load i64, i64* %4, !nosanitize !2
  %6 = add i64 %5, 1
  store i64 %6, i64* %4, !nosanitize !2
  call void @print_char(i64 %6)
  call void @print_value(i64 %6)
  call void @print_value(i64 %5)
  call void @print_value(i64 1)
  %7 = alloca [128 x i8], align 16
  %8 = getelementptr inbounds [128 x i8], [128 x i8]* %7, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 128, i8* nonnull %8) #6
  %9 = getelementptr inbounds i8*, i8** %1, i64 1
  %10 = load i8*, i8** %9, align 8, !tbaa !3
  %11 = tail call %struct._IO_FILE* @fopen(i8* %10, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0))
  %12 = icmp eq %struct._IO_FILE* %11, null
  br i1 %12, label %60, label %13

13:                                               ; preds = %2
  %14 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %15 = getelementptr i64, i64* %14, i64 2
  %16 = load i64, i64* %15, !nosanitize !2
  %17 = add i64 %16, 1
  store i64 %17, i64* %15, !nosanitize !2
  call void @print_char(i64 %17)
  call void @print_value(i64 %17)
  call void @print_value(i64 %16)
  call void @print_value(i64 2)
  %18 = call i8* @fgets_unlocked(i8* nonnull %8, i32 128, %struct._IO_FILE* nonnull %11)
  %19 = icmp eq i8* %18, null
  br i1 %19, label %53, label %20

20:                                               ; preds = %13, %34
  %21 = phi i32 [ %44, %34 ], [ 1, %13 ]
  %22 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %23 = getelementptr i64, i64* %22, i64 3
  %24 = load i64, i64* %23, !nosanitize !2
  %25 = add i64 %24, 1
  store i64 %25, i64* %23, !nosanitize !2
  call void @print_char(i64 %25)
  call void @print_value(i64 %25)
  call void @print_value(i64 %24)
  call void @print_value(i64 3)
  %26 = call i64 @strlen(i8* nonnull %8) #7
  %27 = icmp eq i64 %26, 0
  br i1 %27, label %28, label %34

28:                                               ; preds = %20
  %29 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %30 = getelementptr i64, i64* %29, i64 4
  %31 = load i64, i64* %30, !nosanitize !2
  %32 = add i64 %31, 1
  store i64 %32, i64* %30, !nosanitize !2
  call void @print_char(i64 %32)
  call void @print_value(i64 %32)
  call void @print_value(i64 %31)
  call void @print_value(i64 4)
  %33 = call i32 @puts(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @str.6, i64 0, i64 0))
  call void @exit(i32 1) #8
  unreachable

34:                                               ; preds = %20
  %35 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %36 = getelementptr i64, i64* %35, i64 5
  %37 = load i64, i64* %36, !nosanitize !2
  %38 = add i64 %37, 1
  store i64 %38, i64* %36, !nosanitize !2
  call void @print_char(i64 %38)
  call void @print_value(i64 %38)
  call void @print_value(i64 %37)
  call void @print_value(i64 5)
  %39 = mul nsw i32 %21, 6
  %40 = load i8, i8* %8, align 16, !tbaa !7
  %41 = icmp eq i8 %40, 48
  %42 = select i1 %41, i8* getelementptr inbounds ([25 x i8], [25 x i8]* @str.5, i64 0, i64 0), i8* getelementptr inbounds ([30 x i8], [30 x i8]* @str, i64 0, i64 0)
  %43 = call i32 @puts(i8* %42)
  %44 = add nsw i32 %39, 5
  %45 = call i8* @fgets_unlocked(i8* nonnull %8, i32 128, %struct._IO_FILE* nonnull %11)
  %46 = icmp eq i8* %45, null
  br i1 %46, label %47, label %20

47:                                               ; preds = %34
  %48 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %49 = getelementptr i64, i64* %48, i64 6
  %50 = load i64, i64* %49, !nosanitize !2
  %51 = add i64 %50, 1
  store i64 %51, i64* %49, !nosanitize !2
  call void @print_char(i64 %51)
  call void @print_value(i64 %51)
  call void @print_value(i64 %50)
  call void @print_value(i64 6)
  %52 = select i1 %41, i32 45, i32 %39
  br label %53

53:                                               ; preds = %47, %13
  %54 = phi i32 [ 1, %13 ], [ %52, %47 ]
  %55 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %56 = getelementptr i64, i64* %55, i64 7
  %57 = load i64, i64* %56, !nosanitize !2
  %58 = add i64 %57, 1
  store i64 %58, i64* %56, !nosanitize !2
  call void @print_char(i64 %58)
  call void @print_value(i64 %58)
  call void @print_value(i64 %57)
  call void @print_value(i64 7)
  %59 = call i32 @fclose(%struct._IO_FILE* nonnull %11)
  br label %65

60:                                               ; preds = %2
  %61 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %62 = getelementptr i64, i64* %61, i64 8
  %63 = load i64, i64* %62, !nosanitize !2
  %64 = add i64 %63, 1
  store i64 %64, i64* %62, !nosanitize !2
  call void @print_char(i64 %64)
  call void @print_value(i64 %64)
  call void @print_value(i64 %63)
  call void @print_value(i64 8)
  tail call void @exit(i32 2) #8
  unreachable

65:                                               ; preds = %65, %53
  %66 = phi i32 [ 0, %53 ], [ %71, %65 ]
  %67 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %68 = getelementptr i64, i64* %67, i64 9
  %69 = load i64, i64* %68, !nosanitize !2
  %70 = add i64 %69, 1
  store i64 %70, i64* %68, !nosanitize !2
  call void @print_char(i64 %70)
  call void @print_value(i64 %70)
  call void @print_value(i64 %69)
  call void @print_value(i64 9)
  %71 = add nuw nsw i32 %66, 3
  %72 = icmp eq i32 %71, 5001
  br i1 %72, label %73, label %65

73:                                               ; preds = %65
  %74 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %75 = getelementptr i64, i64* %74, i64 10
  %76 = load i64, i64* %75, !nosanitize !2
  %77 = add i64 %76, 1
  store i64 %77, i64* %75, !nosanitize !2
  call void @print_char(i64 %77)
  call void @print_value(i64 %77)
  call void @print_value(i64 %76)
  call void @print_value(i64 10)
  %78 = add nuw nsw i32 %66, 1
  %79 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.4, i64 0, i64 0), i32 %78)
  %80 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.4, i64 0, i64 0), i32 %54)
  call void @exit(i32 0) #8
  unreachable
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: nofree nounwind
declare dso_local noalias %struct._IO_FILE* @fopen(i8* nocapture readonly, i8* nocapture readonly) local_unnamed_addr #2

; Function Attrs: nofree nounwind
declare i8* @fgets_unlocked(i8*, i32, %struct._IO_FILE* nocapture) local_unnamed_addr #3

; Function Attrs: argmemonly nofree nounwind readonly
declare dso_local i64 @strlen(i8* nocapture) local_unnamed_addr #4

; Function Attrs: nofree nounwind
declare i32 @puts(i8* nocapture readonly) local_unnamed_addr #3

; Function Attrs: noreturn nounwind
declare dso_local void @exit(i32) local_unnamed_addr #5

; Function Attrs: nofree nounwind
declare dso_local i32 @fclose(%struct._IO_FILE* nocapture) local_unnamed_addr #2

; Function Attrs: nofree nounwind
declare dso_local i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #2

declare void @print_value(i64)

declare void @print_char(i8*)

attributes #0 = { noreturn nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { nofree nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nofree nounwind }
attributes #4 = { argmemonly nofree nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nounwind }
attributes #7 = { nounwind readonly }
attributes #8 = { noreturn nounwind }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1}

!0 = !{!"clang version 9.0.1-10 "}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C/C++ TBAA"}
!7 = !{!5, !5, i64 0}
