; ModuleID = 'Tests/test_program/test_instr2.c_1.o.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, %struct._IO_codecvt*, %struct._IO_wide_data*, %struct._IO_FILE*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type opaque
%struct._IO_codecvt = type opaque
%struct._IO_wide_data = type opaque

@.str = private unnamed_addr constant [2 x i8] c"r\00", align 1
@.str.1 = private unnamed_addr constant [18 x i8] c"line %d out of %d\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"file was empty\00", align 1
@.str.3 = private unnamed_addr constant [19 x i8] c"such a small file!\00", align 1
@.str.4 = private unnamed_addr constant [42 x i8] c"The factorial of the lines of input is %d\00", align 1
@__bb_coverage_ptr = external global i64*

; Function Attrs: norecurse nounwind readnone uwtable
define dso_local i32 @calc_factorial(i32) local_unnamed_addr #0 {
  %2 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %3 = getelementptr i64, i64* %2, i64 1
  %4 = load i64, i64* %3, !nosanitize !2
  %5 = add i64 %4, 1
  store i64 %5, i64* %3, !nosanitize !2
  call void @print_char(i64 %5)
  call void @print_value(i64 %5)
  call void @print_value(i64 %4)
  call void @print_value(i64 1)
  %6 = icmp sgt i32 %0, 1
  br i1 %6, label %7, label %106

7:                                                ; preds = %1
  %8 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %9 = getelementptr i64, i64* %8, i64 2
  %10 = load i64, i64* %9, !nosanitize !2
  %11 = add i64 %10, 1
  store i64 %11, i64* %9, !nosanitize !2
  call void @print_char(i64 %11)
  call void @print_value(i64 %11)
  call void @print_value(i64 %10)
  call void @print_value(i64 2)
  %12 = add i32 %0, -1
  %13 = icmp ult i32 %12, 8
  br i1 %13, label %14, label %21

14:                                               ; preds = %92, %7
  %15 = phi i32 [ 1, %7 ], [ %27, %92 ]
  %16 = phi i32 [ 1, %7 ], [ %104, %92 ]
  %17 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %18 = getelementptr i64, i64* %17, i64 3
  %19 = load i64, i64* %18, !nosanitize !2
  %20 = add i64 %19, 1
  store i64 %20, i64* %18, !nosanitize !2
  call void @print_char(i64 %20)
  call void @print_value(i64 %20)
  call void @print_value(i64 %19)
  call void @print_value(i64 3)
  br label %112

21:                                               ; preds = %7
  %22 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %23 = getelementptr i64, i64* %22, i64 4
  %24 = load i64, i64* %23, !nosanitize !2
  %25 = add i64 %24, 1
  store i64 %25, i64* %23, !nosanitize !2
  call void @print_char(i64 %25)
  call void @print_value(i64 %25)
  call void @print_value(i64 %24)
  call void @print_value(i64 4)
  %26 = and i32 %12, -8
  %27 = or i32 %26, 1
  %28 = add i32 %26, -8
  %29 = lshr exact i32 %28, 3
  %30 = add nuw nsw i32 %29, 1
  %31 = and i32 %30, 3
  %32 = icmp ult i32 %28, 24
  br i1 %32, label %66, label %33

33:                                               ; preds = %21
  %34 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %35 = getelementptr i64, i64* %34, i64 5
  %36 = load i64, i64* %35, !nosanitize !2
  %37 = add i64 %36, 1
  store i64 %37, i64* %35, !nosanitize !2
  call void @print_char(i64 %37)
  call void @print_value(i64 %37)
  call void @print_value(i64 %36)
  call void @print_value(i64 5)
  %38 = sub nsw i32 %30, %31
  br label %39

39:                                               ; preds = %39, %33
  %40 = phi <4 x i32> [ <i32 1, i32 2, i32 3, i32 4>, %33 ], [ %63, %39 ]
  %41 = phi <4 x i32> [ <i32 1, i32 1, i32 1, i32 1>, %33 ], [ %61, %39 ]
  %42 = phi <4 x i32> [ <i32 1, i32 1, i32 1, i32 1>, %33 ], [ %62, %39 ]
  %43 = phi i32 [ %38, %33 ], [ %64, %39 ]
  %44 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %45 = getelementptr i64, i64* %44, i64 6
  %46 = load i64, i64* %45, !nosanitize !2
  %47 = add i64 %46, 1
  store i64 %47, i64* %45, !nosanitize !2
  call void @print_char(i64 %47)
  call void @print_value(i64 %47)
  call void @print_value(i64 %46)
  call void @print_value(i64 6)
  %48 = add <4 x i32> %40, <i32 4, i32 4, i32 4, i32 4>
  %49 = mul nsw <4 x i32> %40, %41
  %50 = mul nsw <4 x i32> %48, %42
  %51 = add <4 x i32> %40, <i32 8, i32 8, i32 8, i32 8>
  %52 = add <4 x i32> %40, <i32 12, i32 12, i32 12, i32 12>
  %53 = mul nsw <4 x i32> %51, %49
  %54 = mul nsw <4 x i32> %52, %50
  %55 = add <4 x i32> %40, <i32 16, i32 16, i32 16, i32 16>
  %56 = add <4 x i32> %40, <i32 20, i32 20, i32 20, i32 20>
  %57 = mul nsw <4 x i32> %55, %53
  %58 = mul nsw <4 x i32> %56, %54
  %59 = add <4 x i32> %40, <i32 24, i32 24, i32 24, i32 24>
  %60 = add <4 x i32> %40, <i32 28, i32 28, i32 28, i32 28>
  %61 = mul nsw <4 x i32> %59, %57
  %62 = mul nsw <4 x i32> %60, %58
  %63 = add <4 x i32> %40, <i32 32, i32 32, i32 32, i32 32>
  %64 = add i32 %43, -4
  %65 = icmp eq i32 %64, 0
  br i1 %65, label %66, label %39, !llvm.loop !3

66:                                               ; preds = %39, %21
  %67 = phi <4 x i32> [ undef, %21 ], [ %61, %39 ]
  %68 = phi <4 x i32> [ undef, %21 ], [ %62, %39 ]
  %69 = phi <4 x i32> [ <i32 1, i32 2, i32 3, i32 4>, %21 ], [ %63, %39 ]
  %70 = phi <4 x i32> [ <i32 1, i32 1, i32 1, i32 1>, %21 ], [ %61, %39 ]
  %71 = phi <4 x i32> [ <i32 1, i32 1, i32 1, i32 1>, %21 ], [ %62, %39 ]
  %72 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %73 = getelementptr i64, i64* %72, i64 7
  %74 = load i64, i64* %73, !nosanitize !2
  %75 = add i64 %74, 1
  store i64 %75, i64* %73, !nosanitize !2
  call void @print_char(i64 %75)
  call void @print_value(i64 %75)
  call void @print_value(i64 %74)
  call void @print_value(i64 7)
  %76 = icmp eq i32 %31, 0
  br i1 %76, label %92, label %77

77:                                               ; preds = %66, %77
  %78 = phi <4 x i32> [ %89, %77 ], [ %69, %66 ]
  %79 = phi <4 x i32> [ %87, %77 ], [ %70, %66 ]
  %80 = phi <4 x i32> [ %88, %77 ], [ %71, %66 ]
  %81 = phi i32 [ %90, %77 ], [ %31, %66 ]
  %82 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %83 = getelementptr i64, i64* %82, i64 8
  %84 = load i64, i64* %83, !nosanitize !2
  %85 = add i64 %84, 1
  store i64 %85, i64* %83, !nosanitize !2
  call void @print_char(i64 %85)
  call void @print_value(i64 %85)
  call void @print_value(i64 %84)
  call void @print_value(i64 8)
  %86 = add <4 x i32> %78, <i32 4, i32 4, i32 4, i32 4>
  %87 = mul nsw <4 x i32> %78, %79
  %88 = mul nsw <4 x i32> %86, %80
  %89 = add <4 x i32> %78, <i32 8, i32 8, i32 8, i32 8>
  %90 = add i32 %81, -1
  %91 = icmp eq i32 %90, 0
  br i1 %91, label %92, label %77, !llvm.loop !5

92:                                               ; preds = %77, %66
  %93 = phi <4 x i32> [ %67, %66 ], [ %87, %77 ]
  %94 = phi <4 x i32> [ %68, %66 ], [ %88, %77 ]
  %95 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %96 = getelementptr i64, i64* %95, i64 9
  %97 = load i64, i64* %96, !nosanitize !2
  %98 = add i64 %97, 1
  store i64 %98, i64* %96, !nosanitize !2
  call void @print_char(i64 %98)
  call void @print_value(i64 %98)
  call void @print_value(i64 %97)
  call void @print_value(i64 9)
  %99 = mul <4 x i32> %94, %93
  %100 = shufflevector <4 x i32> %99, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %101 = mul <4 x i32> %99, %100
  %102 = shufflevector <4 x i32> %101, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %103 = mul <4 x i32> %101, %102
  %104 = extractelement <4 x i32> %103, i32 0
  %105 = icmp eq i32 %12, %26
  br i1 %105, label %106, label %14

106:                                              ; preds = %112, %92, %1
  %107 = phi i32 [ 1, %1 ], [ %104, %92 ], [ %119, %112 ]
  %108 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %109 = getelementptr i64, i64* %108, i64 10
  %110 = load i64, i64* %109, !nosanitize !2
  %111 = add i64 %110, 1
  store i64 %111, i64* %109, !nosanitize !2
  call void @print_char(i64 %111)
  call void @print_value(i64 %111)
  call void @print_value(i64 %110)
  call void @print_value(i64 10)
  ret i32 %107

112:                                              ; preds = %14, %112
  %113 = phi i32 [ %120, %112 ], [ %15, %14 ]
  %114 = phi i32 [ %119, %112 ], [ %16, %14 ]
  %115 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %116 = getelementptr i64, i64* %115, i64 11
  %117 = load i64, i64* %116, !nosanitize !2
  %118 = add i64 %117, 1
  store i64 %118, i64* %116, !nosanitize !2
  call void @print_char(i64 %118)
  call void @print_value(i64 %118)
  call void @print_value(i64 %117)
  call void @print_value(i64 11)
  %119 = mul nsw i32 %113, %114
  %120 = add nuw nsw i32 %113, 1
  %121 = icmp eq i32 %120, %0
  br i1 %121, label %106, label %112, !llvm.loop !7
}

; Function Attrs: noreturn nounwind uwtable
define dso_local i32 @main(i32, i8** nocapture readonly) local_unnamed_addr #1 {
  %3 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %4 = getelementptr i64, i64* %3, i64 12
  %5 = load i64, i64* %4, !nosanitize !2
  %6 = add i64 %5, 1
  store i64 %6, i64* %4, !nosanitize !2
  call void @print_char(i64 %6)
  call void @print_value(i64 %6)
  call void @print_value(i64 %5)
  call void @print_value(i64 12)
  %7 = alloca [128 x i8], align 16
  %8 = getelementptr inbounds [128 x i8], [128 x i8]* %7, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 128, i8* nonnull %8) #6
  %9 = getelementptr inbounds i8*, i8** %1, i64 1
  %10 = load i8*, i8** %9, align 8, !tbaa !9
  %11 = tail call %struct._IO_FILE* @fopen(i8* %10, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0))
  %12 = icmp eq %struct._IO_FILE* %11, null
  br i1 %12, label %29, label %13

13:                                               ; preds = %2, %13
  %14 = phi i32 [ %21, %13 ], [ 0, %2 ]
  %15 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %16 = getelementptr i64, i64* %15, i64 13
  %17 = load i64, i64* %16, !nosanitize !2
  %18 = add i64 %17, 1
  store i64 %18, i64* %16, !nosanitize !2
  call void @print_char(i64 %18)
  call void @print_value(i64 %18)
  call void @print_value(i64 %17)
  call void @print_value(i64 13)
  %19 = call i8* @fgets_unlocked(i8* nonnull %8, i32 128, %struct._IO_FILE* nonnull %11)
  %20 = icmp eq i8* %19, null
  %21 = add nuw nsw i32 %14, 1
  br i1 %20, label %22, label %13

22:                                               ; preds = %13
  %23 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %24 = getelementptr i64, i64* %23, i64 14
  %25 = load i64, i64* %24, !nosanitize !2
  %26 = add i64 %25, 1
  store i64 %26, i64* %24, !nosanitize !2
  call void @print_char(i64 %26)
  call void @print_value(i64 %26)
  call void @print_value(i64 %25)
  call void @print_value(i64 14)
  %27 = call i32 @fclose(%struct._IO_FILE* nonnull %11)
  %28 = icmp eq i32 %14, 0
  br i1 %28, label %147, label %34

29:                                               ; preds = %2
  %30 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %31 = getelementptr i64, i64* %30, i64 15
  %32 = load i64, i64* %31, !nosanitize !2
  %33 = add i64 %32, 1
  store i64 %33, i64* %31, !nosanitize !2
  call void @print_char(i64 %33)
  call void @print_value(i64 %33)
  call void @print_value(i64 %32)
  call void @print_value(i64 15)
  tail call void @exit(i32 2) #7
  unreachable

34:                                               ; preds = %22, %34
  %35 = phi i32 [ %41, %34 ], [ 0, %22 ]
  %36 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %37 = getelementptr i64, i64* %36, i64 16
  %38 = load i64, i64* %37, !nosanitize !2
  %39 = add i64 %38, 1
  store i64 %39, i64* %37, !nosanitize !2
  call void @print_char(i64 %39)
  call void @print_value(i64 %39)
  call void @print_value(i64 %38)
  call void @print_value(i64 16)
  %40 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.1, i64 0, i64 0), i32 %35, i32 %14)
  %41 = add nuw nsw i32 %35, 1
  %42 = icmp eq i32 %41, %14
  br i1 %42, label %43, label %34

43:                                               ; preds = %34
  %44 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %45 = getelementptr i64, i64* %44, i64 17
  %46 = load i64, i64* %45, !nosanitize !2
  %47 = add i64 %46, 1
  store i64 %47, i64* %45, !nosanitize !2
  call void @print_char(i64 %47)
  call void @print_value(i64 %47)
  call void @print_value(i64 %46)
  call void @print_value(i64 17)
  switch i32 %14, label %48 [
    i32 0, label %147
    i32 1, label %153
  ]

48:                                               ; preds = %43
  %49 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %50 = getelementptr i64, i64* %49, i64 18
  %51 = load i64, i64* %50, !nosanitize !2
  %52 = add i64 %51, 1
  store i64 %52, i64* %50, !nosanitize !2
  call void @print_char(i64 %52)
  call void @print_value(i64 %52)
  call void @print_value(i64 %51)
  call void @print_value(i64 18)
  %53 = add nsw i32 %14, -1
  %54 = icmp ult i32 %53, 8
  br i1 %54, label %55, label %62

55:                                               ; preds = %133, %48
  %56 = phi i32 [ 1, %48 ], [ %68, %133 ]
  %57 = phi i32 [ 1, %48 ], [ %145, %133 ]
  %58 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %59 = getelementptr i64, i64* %58, i64 19
  %60 = load i64, i64* %59, !nosanitize !2
  %61 = add i64 %60, 1
  store i64 %61, i64* %59, !nosanitize !2
  call void @print_char(i64 %61)
  call void @print_value(i64 %61)
  call void @print_value(i64 %60)
  call void @print_value(i64 19)
  br label %159

62:                                               ; preds = %48
  %63 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %64 = getelementptr i64, i64* %63, i64 20
  %65 = load i64, i64* %64, !nosanitize !2
  %66 = add i64 %65, 1
  store i64 %66, i64* %64, !nosanitize !2
  call void @print_char(i64 %66)
  call void @print_value(i64 %66)
  call void @print_value(i64 %65)
  call void @print_value(i64 20)
  %67 = and i32 %53, -8
  %68 = or i32 %67, 1
  %69 = add i32 %67, -8
  %70 = lshr exact i32 %69, 3
  %71 = add nuw nsw i32 %70, 1
  %72 = and i32 %71, 3
  %73 = icmp ult i32 %69, 24
  br i1 %73, label %107, label %74

74:                                               ; preds = %62
  %75 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %76 = getelementptr i64, i64* %75, i64 21
  %77 = load i64, i64* %76, !nosanitize !2
  %78 = add i64 %77, 1
  store i64 %78, i64* %76, !nosanitize !2
  call void @print_char(i64 %78)
  call void @print_value(i64 %78)
  call void @print_value(i64 %77)
  call void @print_value(i64 21)
  %79 = sub nsw i32 %71, %72
  br label %80

80:                                               ; preds = %80, %74
  %81 = phi <4 x i32> [ <i32 1, i32 2, i32 3, i32 4>, %74 ], [ %104, %80 ]
  %82 = phi <4 x i32> [ <i32 1, i32 1, i32 1, i32 1>, %74 ], [ %102, %80 ]
  %83 = phi <4 x i32> [ <i32 1, i32 1, i32 1, i32 1>, %74 ], [ %103, %80 ]
  %84 = phi i32 [ %79, %74 ], [ %105, %80 ]
  %85 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %86 = getelementptr i64, i64* %85, i64 22
  %87 = load i64, i64* %86, !nosanitize !2
  %88 = add i64 %87, 1
  store i64 %88, i64* %86, !nosanitize !2
  call void @print_char(i64 %88)
  call void @print_value(i64 %88)
  call void @print_value(i64 %87)
  call void @print_value(i64 22)
  %89 = add <4 x i32> %81, <i32 4, i32 4, i32 4, i32 4>
  %90 = mul nsw <4 x i32> %82, %81
  %91 = mul nsw <4 x i32> %83, %89
  %92 = add <4 x i32> %81, <i32 8, i32 8, i32 8, i32 8>
  %93 = add <4 x i32> %81, <i32 12, i32 12, i32 12, i32 12>
  %94 = mul nsw <4 x i32> %90, %92
  %95 = mul nsw <4 x i32> %91, %93
  %96 = add <4 x i32> %81, <i32 16, i32 16, i32 16, i32 16>
  %97 = add <4 x i32> %81, <i32 20, i32 20, i32 20, i32 20>
  %98 = mul nsw <4 x i32> %94, %96
  %99 = mul nsw <4 x i32> %95, %97
  %100 = add <4 x i32> %81, <i32 24, i32 24, i32 24, i32 24>
  %101 = add <4 x i32> %81, <i32 28, i32 28, i32 28, i32 28>
  %102 = mul nsw <4 x i32> %98, %100
  %103 = mul nsw <4 x i32> %99, %101
  %104 = add <4 x i32> %81, <i32 32, i32 32, i32 32, i32 32>
  %105 = add i32 %84, -4
  %106 = icmp eq i32 %105, 0
  br i1 %106, label %107, label %80, !llvm.loop !13

107:                                              ; preds = %80, %62
  %108 = phi <4 x i32> [ undef, %62 ], [ %102, %80 ]
  %109 = phi <4 x i32> [ undef, %62 ], [ %103, %80 ]
  %110 = phi <4 x i32> [ <i32 1, i32 2, i32 3, i32 4>, %62 ], [ %104, %80 ]
  %111 = phi <4 x i32> [ <i32 1, i32 1, i32 1, i32 1>, %62 ], [ %102, %80 ]
  %112 = phi <4 x i32> [ <i32 1, i32 1, i32 1, i32 1>, %62 ], [ %103, %80 ]
  %113 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %114 = getelementptr i64, i64* %113, i64 23
  %115 = load i64, i64* %114, !nosanitize !2
  %116 = add i64 %115, 1
  store i64 %116, i64* %114, !nosanitize !2
  call void @print_char(i64 %116)
  call void @print_value(i64 %116)
  call void @print_value(i64 %115)
  call void @print_value(i64 23)
  %117 = icmp eq i32 %72, 0
  br i1 %117, label %133, label %118

118:                                              ; preds = %107, %118
  %119 = phi <4 x i32> [ %130, %118 ], [ %110, %107 ]
  %120 = phi <4 x i32> [ %128, %118 ], [ %111, %107 ]
  %121 = phi <4 x i32> [ %129, %118 ], [ %112, %107 ]
  %122 = phi i32 [ %131, %118 ], [ %72, %107 ]
  %123 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %124 = getelementptr i64, i64* %123, i64 24
  %125 = load i64, i64* %124, !nosanitize !2
  %126 = add i64 %125, 1
  store i64 %126, i64* %124, !nosanitize !2
  call void @print_char(i64 %126)
  call void @print_value(i64 %126)
  call void @print_value(i64 %125)
  call void @print_value(i64 24)
  %127 = add <4 x i32> %119, <i32 4, i32 4, i32 4, i32 4>
  %128 = mul nsw <4 x i32> %120, %119
  %129 = mul nsw <4 x i32> %121, %127
  %130 = add <4 x i32> %119, <i32 8, i32 8, i32 8, i32 8>
  %131 = add i32 %122, -1
  %132 = icmp eq i32 %131, 0
  br i1 %132, label %133, label %118, !llvm.loop !14

133:                                              ; preds = %118, %107
  %134 = phi <4 x i32> [ %108, %107 ], [ %128, %118 ]
  %135 = phi <4 x i32> [ %109, %107 ], [ %129, %118 ]
  %136 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %137 = getelementptr i64, i64* %136, i64 25
  %138 = load i64, i64* %137, !nosanitize !2
  %139 = add i64 %138, 1
  store i64 %139, i64* %137, !nosanitize !2
  call void @print_char(i64 %139)
  call void @print_value(i64 %139)
  call void @print_value(i64 %138)
  call void @print_value(i64 25)
  %140 = mul <4 x i32> %135, %134
  %141 = shufflevector <4 x i32> %140, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %142 = mul <4 x i32> %140, %141
  %143 = shufflevector <4 x i32> %142, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %144 = mul <4 x i32> %142, %143
  %145 = extractelement <4 x i32> %144, i32 0
  %146 = icmp eq i32 %53, %67
  br i1 %146, label %169, label %55

147:                                              ; preds = %22, %43
  %148 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %149 = getelementptr i64, i64* %148, i64 26
  %150 = load i64, i64* %149, !nosanitize !2
  %151 = add i64 %150, 1
  store i64 %151, i64* %149, !nosanitize !2
  call void @print_char(i64 %151)
  call void @print_value(i64 %151)
  call void @print_value(i64 %150)
  call void @print_value(i64 26)
  %152 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.2, i64 0, i64 0))
  br label %176

153:                                              ; preds = %43
  %154 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %155 = getelementptr i64, i64* %154, i64 27
  %156 = load i64, i64* %155, !nosanitize !2
  %157 = add i64 %156, 1
  store i64 %157, i64* %155, !nosanitize !2
  call void @print_char(i64 %157)
  call void @print_value(i64 %157)
  call void @print_value(i64 %156)
  call void @print_value(i64 27)
  %158 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.3, i64 0, i64 0))
  br label %176

159:                                              ; preds = %55, %159
  %160 = phi i32 [ %167, %159 ], [ %56, %55 ]
  %161 = phi i32 [ %166, %159 ], [ %57, %55 ]
  %162 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %163 = getelementptr i64, i64* %162, i64 28
  %164 = load i64, i64* %163, !nosanitize !2
  %165 = add i64 %164, 1
  store i64 %165, i64* %163, !nosanitize !2
  call void @print_char(i64 %165)
  call void @print_value(i64 %165)
  call void @print_value(i64 %164)
  call void @print_value(i64 28)
  %166 = mul nsw i32 %161, %160
  %167 = add nuw nsw i32 %160, 1
  %168 = icmp eq i32 %167, %14
  br i1 %168, label %169, label %159, !llvm.loop !15

169:                                              ; preds = %159, %133
  %170 = phi i32 [ %145, %133 ], [ %166, %159 ]
  %171 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %172 = getelementptr i64, i64* %171, i64 29
  %173 = load i64, i64* %172, !nosanitize !2
  %174 = add i64 %173, 1
  store i64 %174, i64* %172, !nosanitize !2
  call void @print_char(i64 %174)
  call void @print_value(i64 %174)
  call void @print_value(i64 %173)
  call void @print_value(i64 29)
  %175 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([42 x i8], [42 x i8]* @.str.4, i64 0, i64 0), i32 %170)
  br label %176

176:                                              ; preds = %169, %153, %147
  %177 = load i64*, i64** @__bb_coverage_ptr, !nosanitize !2
  %178 = getelementptr i64, i64* %177, i64 30
  %179 = load i64, i64* %178, !nosanitize !2
  %180 = add i64 %179, 1
  store i64 %180, i64* %178, !nosanitize !2
  call void @print_char(i64 %180)
  call void @print_value(i64 %180)
  call void @print_value(i64 %179)
  call void @print_value(i64 30)
  call void @exit(i32 0) #7
  unreachable
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: nofree nounwind
declare dso_local noalias %struct._IO_FILE* @fopen(i8* nocapture readonly, i8* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nofree nounwind
declare i8* @fgets_unlocked(i8*, i32, %struct._IO_FILE* nocapture) local_unnamed_addr #4

; Function Attrs: nofree nounwind
declare dso_local i32 @fclose(%struct._IO_FILE* nocapture) local_unnamed_addr #3

; Function Attrs: noreturn nounwind
declare dso_local void @exit(i32) local_unnamed_addr #5

; Function Attrs: nofree nounwind
declare dso_local i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #3

declare void @print_value(i64)

declare void @print_char(i8*)

attributes #0 = { norecurse nounwind readnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noreturn nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { argmemonly nounwind }
attributes #3 = { nofree nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nofree nounwind }
attributes #5 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nounwind }
attributes #7 = { noreturn nounwind }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1}

!0 = !{!"clang version 9.0.1-10 "}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{}
!3 = distinct !{!3, !4}
!4 = !{!"llvm.loop.isvectorized", i32 1}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.unroll.disable"}
!7 = distinct !{!7, !8, !4}
!8 = !{!"llvm.loop.unroll.runtime.disable"}
!9 = !{!10, !10, i64 0}
!10 = !{!"any pointer", !11, i64 0}
!11 = !{!"omnipotent char", !12, i64 0}
!12 = !{!"Simple C/C++ TBAA"}
!13 = distinct !{!13, !4}
!14 = distinct !{!14, !6}
!15 = distinct !{!15, !8, !4}
