; ModuleID = 'mm.c'
source_filename = "mm.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.block = type { i64, %union.anon }
%union.anon = type { %struct.anon }
%struct.anon = type { %struct.block*, %struct.block* }

@.str = private unnamed_addr constant [45 x i8] c"\0AERROR at line %d: incorrect prologue at %p\0A\00", align 1
@heap_start = internal unnamed_addr global %struct.block* null, align 8, !dbg !0
@.str.1 = private unnamed_addr constant [64 x i8] c"\0AERROR at line %d: block at %p not aligned to 16-byte boundary\0A\00", align 1
@.str.2 = private unnamed_addr constant [58 x i8] c"\0AERROR at line %d: two adjacent free blocks at %p and %p\0A\00", align 1
@.str.3 = private unnamed_addr constant [51 x i8] c"\0AERROR at line %d: block at %p is outside of heap\0A\00", align 1
@.str.4 = private unnamed_addr constant [66 x i8] c"\0AERROR at line %d: block at %p has mismatching header and footer\0A\00", align 1
@.str.5 = private unnamed_addr constant [45 x i8] c"\0AERROR at line %d: block at %p is too small\0A\00", align 1
@.str.6 = private unnamed_addr constant [50 x i8] c"\0AERROR at line %d: invalid end dummy block at %p\0A\00", align 1
@seglists = internal unnamed_addr global %struct.block** null, align 8, !dbg !58
@.str.7 = private unnamed_addr constant [72 x i8] c"\0AERROR at line %d: free block at %p is located in wrong freelist class\0A\00", align 1
@.str.8 = private unnamed_addr constant [61 x i8] c"\0AERROR at line %d: allocated block at %p found in free list\0A\00", align 1
@.str.9 = private unnamed_addr constant [91 x i8] c"\0AERROR at line %d: free block at %p has mismatching pointers with prev or next free block\0A\00", align 1
@.str.10 = private unnamed_addr constant [63 x i8] c"\0AERROR at line %d: free block at %p is not within heap bounds\0A\00", align 1
@.str.11 = private unnamed_addr constant [91 x i8] c"\0AERROR at line %d: different number of free blocks in freelist (%ld) vs heap memory (%ld)\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local zeroext i1 @mm_checkheap(i32 noundef %0) local_unnamed_addr #0 !dbg !71 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !76, metadata !DIExpression()), !dbg !88
  %2 = tail call i8* @mem_heap_lo() #6, !dbg !89
  call void @llvm.dbg.value(metadata i8* %2, metadata !78, metadata !DIExpression()), !dbg !88
  %3 = tail call i8* @mem_heap_hi() #6, !dbg !90
  call void @llvm.dbg.value(metadata i8* %3, metadata !79, metadata !DIExpression()), !dbg !88
  call void @llvm.dbg.value(metadata i64 0, metadata !80, metadata !DIExpression()), !dbg !88
  call void @llvm.dbg.value(metadata i64 0, metadata !81, metadata !DIExpression()), !dbg !88
  %4 = getelementptr inbounds i8, i8* %2, i64 320, !dbg !91
  %5 = bitcast i8* %4 to i64*, !dbg !91
  %6 = load i64, i64* %5, align 8, !dbg !93, !tbaa !94
  call void @llvm.dbg.value(metadata i64* undef, metadata !98, metadata !DIExpression()), !dbg !103
  %7 = and i64 %6, -15, !dbg !105
  %8 = icmp eq i64 %7, 1, !dbg !105
  br i1 %8, label %11, label %9, !dbg !106

9:                                                ; preds = %1
  %10 = tail call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([45 x i8], [45 x i8]* @.str, i64 0, i64 0), i32 noundef %0, i8* noundef nonnull %2), !dbg !107
  br label %198, !dbg !109

11:                                               ; preds = %1
  %12 = load %struct.block*, %struct.block** @heap_start, align 8, !dbg !110, !tbaa !112
  call void @llvm.dbg.value(metadata %struct.block* %12, metadata !77, metadata !DIExpression()), !dbg !88
  call void @llvm.dbg.value(metadata i64 0, metadata !81, metadata !DIExpression()), !dbg !88
  %13 = getelementptr %struct.block, %struct.block* %12, i64 0, i32 0, !dbg !114
  %14 = load i64, i64* %13, align 8, !dbg !114, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !123
  call void @llvm.dbg.value(metadata i64 %14, metadata !125, metadata !DIExpression()), !dbg !130
  %15 = and i64 %14, -16, !dbg !132
  %16 = icmp eq i64 %15, 0, !dbg !133
  br i1 %16, label %77, label %17, !dbg !134

17:                                               ; preds = %11, %65
  %18 = phi i64 [ %73, %65 ], [ %15, %11 ]
  %19 = phi i64 [ %72, %65 ], [ %14, %11 ]
  %20 = phi i64 [ %68, %65 ], [ 0, %11 ]
  %21 = phi %struct.block* [ %70, %65 ], [ %12, %11 ]
  call void @llvm.dbg.value(metadata i64 %20, metadata !81, metadata !DIExpression()), !dbg !88
  call void @llvm.dbg.value(metadata %struct.block* %21, metadata !77, metadata !DIExpression()), !dbg !88
  call void @llvm.dbg.value(metadata %struct.block* %21, metadata !135, metadata !DIExpression()), !dbg !140
  call void @llvm.dbg.value(metadata %struct.block* %21, metadata !144, metadata !DIExpression()), !dbg !149
  %22 = getelementptr inbounds %struct.block, %struct.block* %21, i64 0, i32 1, !dbg !151
  %23 = ptrtoint %union.anon* %22 to i64, !dbg !152
  %24 = and i64 %23, 15, !dbg !153
  %25 = icmp eq i64 %24, 0, !dbg !154
  br i1 %25, label %28, label %26, !dbg !155

26:                                               ; preds = %17
  %27 = tail call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([64 x i8], [64 x i8]* @.str.1, i64 0, i64 0), i32 noundef %0, %struct.block* noundef nonnull %21), !dbg !156
  br label %198, !dbg !158

28:                                               ; preds = %17
  call void @llvm.dbg.value(metadata %struct.block* %21, metadata !159, metadata !DIExpression()), !dbg !162
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !165, metadata !DIExpression()), !dbg !168
  call void @llvm.dbg.value(metadata i64 %19, metadata !171, metadata !DIExpression()), !dbg !176
  %29 = and i64 %19, 1, !dbg !178
  %30 = icmp eq i64 %29, 0, !dbg !179
  br i1 %30, label %31, label %40, !dbg !180

31:                                               ; preds = %28
  call void @llvm.dbg.value(metadata %struct.block* %21, metadata !181, metadata !DIExpression()), !dbg !186
  %32 = bitcast %struct.block* %21 to i8*, !dbg !188
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !189
  call void @llvm.dbg.value(metadata i64 %19, metadata !125, metadata !DIExpression()), !dbg !191
  %33 = getelementptr inbounds i8, i8* %32, i64 %18, !dbg !193
  %34 = bitcast i8* %33 to i64*, !dbg !194
  %35 = load i64, i64* %34, align 8, !dbg !194, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !165, metadata !DIExpression()), !dbg !195
  call void @llvm.dbg.value(metadata i64 %35, metadata !171, metadata !DIExpression()), !dbg !197
  %36 = and i64 %35, 1, !dbg !199
  %37 = icmp eq i64 %36, 0, !dbg !200
  br i1 %37, label %38, label %40, !dbg !201

38:                                               ; preds = %31
  call void @llvm.dbg.value(metadata %struct.block* %21, metadata !181, metadata !DIExpression()), !dbg !202
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !205
  call void @llvm.dbg.value(metadata i64 undef, metadata !125, metadata !DIExpression()), !dbg !207
  %39 = tail call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([58 x i8], [58 x i8]* @.str.2, i64 0, i64 0), i32 noundef %0, %struct.block* noundef nonnull %21, i8* noundef nonnull %33), !dbg !209
  br label %198, !dbg !210

40:                                               ; preds = %28, %31
  %41 = bitcast %struct.block* %21 to i8*, !dbg !211
  call void @llvm.dbg.value(metadata %struct.block* %21, metadata !216, metadata !DIExpression()), !dbg !222
  call void @llvm.dbg.value(metadata i8* %2, metadata !217, metadata !DIExpression()), !dbg !222
  call void @llvm.dbg.value(metadata i8* %3, metadata !218, metadata !DIExpression()), !dbg !222
  call void @llvm.dbg.value(metadata %struct.block* %21, metadata !223, metadata !DIExpression()), !dbg !228
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !230
  call void @llvm.dbg.value(metadata i64 %19, metadata !125, metadata !DIExpression()), !dbg !232
  %42 = getelementptr inbounds %union.anon, %union.anon* %22, i64 -1, !dbg !234
  %43 = bitcast %union.anon* %42 to i8*, !dbg !234
  %44 = getelementptr inbounds i8, i8* %43, i64 %18, !dbg !235
  call void @llvm.dbg.value(metadata i8* %44, metadata !219, metadata !DIExpression()), !dbg !222
  %45 = icmp ult i8* %2, %41, !dbg !236
  %46 = icmp ult i8* %44, %3, !dbg !237
  %47 = select i1 %45, i1 %46, i1 false, !dbg !237
  br i1 %47, label %50, label %48, !dbg !238

48:                                               ; preds = %40
  %49 = tail call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([51 x i8], [51 x i8]* @.str.3, i64 0, i64 0), i32 noundef %0, %struct.block* noundef nonnull %21), !dbg !239
  br label %198, !dbg !241

50:                                               ; preds = %40
  call void @llvm.dbg.value(metadata %struct.block* %21, metadata !242, metadata !DIExpression()), !dbg !248
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !251, metadata !DIExpression()), !dbg !254
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !256
  call void @llvm.dbg.value(metadata i64 %19, metadata !125, metadata !DIExpression()), !dbg !258
  %51 = icmp eq i64 %18, 16, !dbg !260
  %52 = icmp ne i64 %29, 0
  %53 = or i1 %51, %52, !dbg !261
  br i1 %53, label %60, label %54, !dbg !261

54:                                               ; preds = %50
  call void @llvm.dbg.value(metadata %struct.block* %21, metadata !223, metadata !DIExpression()), !dbg !262
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !264
  call void @llvm.dbg.value(metadata i64 %19, metadata !125, metadata !DIExpression()), !dbg !266
  %55 = bitcast i8* %44 to i64*, !dbg !268
  call void @llvm.dbg.value(metadata i64* %55, metadata !245, metadata !DIExpression()), !dbg !269
  %56 = load i64, i64* %55, align 8, !dbg !270, !tbaa !94
  %57 = icmp eq i64 %19, %56, !dbg !271
  br i1 %57, label %60, label %58, !dbg !272

58:                                               ; preds = %54
  %59 = tail call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([66 x i8], [66 x i8]* @.str.4, i64 0, i64 0), i32 noundef %0, %struct.block* noundef nonnull %21), !dbg !273
  br label %198, !dbg !275

60:                                               ; preds = %50, %54
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !276
  call void @llvm.dbg.value(metadata i64 undef, metadata !125, metadata !DIExpression()), !dbg !279
  %61 = icmp ugt i64 %18, 31, !dbg !281
  %62 = or i1 %61, %51, !dbg !282
  br i1 %62, label %65, label %63, !dbg !282

63:                                               ; preds = %60
  %64 = tail call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([45 x i8], [45 x i8]* @.str.5, i64 0, i64 0), i32 noundef %0, %struct.block* noundef nonnull %21), !dbg !283
  br label %198, !dbg !285

65:                                               ; preds = %60
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !165, metadata !DIExpression()), !dbg !286
  call void @llvm.dbg.value(metadata i64 undef, metadata !171, metadata !DIExpression()), !dbg !289
  %66 = xor i1 %52, true, !dbg !291
  %67 = zext i1 %66 to i64, !dbg !291
  %68 = add i64 %20, %67, !dbg !291
  call void @llvm.dbg.value(metadata i64 %68, metadata !81, metadata !DIExpression()), !dbg !88
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !181, metadata !DIExpression()), !dbg !292
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !294
  call void @llvm.dbg.value(metadata i64 undef, metadata !125, metadata !DIExpression()), !dbg !296
  %69 = getelementptr inbounds i8, i8* %41, i64 %18, !dbg !298
  %70 = bitcast i8* %69 to %struct.block*, !dbg !299
  call void @llvm.dbg.value(metadata %struct.block* %70, metadata !77, metadata !DIExpression()), !dbg !88
  %71 = bitcast i8* %69 to i64*, !dbg !114
  %72 = load i64, i64* %71, align 8, !dbg !114, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !123
  call void @llvm.dbg.value(metadata i64 %72, metadata !125, metadata !DIExpression()), !dbg !130
  %73 = and i64 %72, -16, !dbg !132
  %74 = icmp eq i64 %73, 0, !dbg !133
  br i1 %74, label %75, label %17, !dbg !134, !llvm.loop !300

75:                                               ; preds = %65
  %76 = bitcast i8* %69 to %struct.block*, !dbg !299
  br label %77, !dbg !303

77:                                               ; preds = %75, %11
  %78 = phi %struct.block* [ %12, %11 ], [ %76, %75 ], !dbg !309
  %79 = phi i64 [ 0, %11 ], [ %68, %75 ], !dbg !310
  %80 = phi i64 [ %14, %11 ], [ %72, %75 ], !dbg !114
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !306, metadata !DIExpression()), !dbg !311
  %81 = and i64 %80, -15, !dbg !303
  %82 = icmp eq i64 %81, 1, !dbg !303
  br i1 %82, label %83, label %85, !dbg !312

83:                                               ; preds = %77
  %84 = load %struct.block**, %struct.block*** @seglists, align 8, !tbaa !112
  call void @llvm.dbg.value(metadata i64 0, metadata !82, metadata !DIExpression()), !dbg !313
  call void @llvm.dbg.value(metadata i64 0, metadata !80, metadata !DIExpression()), !dbg !88
  br label %87, !dbg !314

85:                                               ; preds = %77
  %86 = tail call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([50 x i8], [50 x i8]* @.str.6, i64 0, i64 0), i32 noundef %0, %struct.block* noundef nonnull %78), !dbg !315
  br label %198, !dbg !317

87:                                               ; preds = %83, %190
  %88 = phi i64 [ 0, %83 ], [ %192, %190 ]
  %89 = phi i64 [ 0, %83 ], [ %191, %190 ]
  call void @llvm.dbg.value(metadata i64 %88, metadata !82, metadata !DIExpression()), !dbg !313
  call void @llvm.dbg.value(metadata i64 %89, metadata !80, metadata !DIExpression()), !dbg !88
  %90 = getelementptr inbounds %struct.block*, %struct.block** %84, i64 %88, !dbg !318
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !84, metadata !DIExpression()), !dbg !319
  %91 = load %struct.block*, %struct.block** %90, align 8, !dbg !319, !tbaa !320
  call void @llvm.dbg.value(metadata %struct.block* %91, metadata !84, metadata !DIExpression()), !dbg !319
  %92 = icmp eq %struct.block* %91, null, !dbg !321
  br i1 %92, label %190, label %93, !dbg !323

93:                                               ; preds = %87
  %94 = icmp eq i64 %88, 0
  br i1 %94, label %95, label %119, !dbg !324

95:                                               ; preds = %93, %114
  %96 = phi %struct.block* [ %117, %114 ], [ %91, %93 ]
  %97 = phi i64 [ %115, %114 ], [ %89, %93 ]
  call void @llvm.dbg.value(metadata i64 %97, metadata !80, metadata !DIExpression()), !dbg !88
  %98 = getelementptr %struct.block, %struct.block* %96, i64 0, i32 0, !dbg !327
  %99 = load i64, i64* %98, align 8, !dbg !327, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !329
  call void @llvm.dbg.value(metadata i64 %99, metadata !125, metadata !DIExpression()), !dbg !331
  %100 = and i64 %99, -16, !dbg !333
  call void @llvm.dbg.value(metadata i64 %100, metadata !334, metadata !DIExpression()), !dbg !340
  %101 = icmp eq i64 %100, 16, !dbg !342
  br i1 %101, label %102, label %137, !dbg !342

102:                                              ; preds = %95
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !165, metadata !DIExpression()), !dbg !343
  call void @llvm.dbg.value(metadata i64 %99, metadata !171, metadata !DIExpression()), !dbg !346
  %103 = and i64 %99, 1, !dbg !348
  %104 = icmp eq i64 %103, 0, !dbg !349
  br i1 %104, label %105, label %143, !dbg !350

105:                                              ; preds = %102
  call void @llvm.dbg.value(metadata %struct.block* %96, metadata !216, metadata !DIExpression()), !dbg !351
  call void @llvm.dbg.value(metadata i8* %2, metadata !217, metadata !DIExpression()), !dbg !351
  call void @llvm.dbg.value(metadata i8* %3, metadata !218, metadata !DIExpression()), !dbg !351
  call void @llvm.dbg.value(metadata %struct.block* %96, metadata !223, metadata !DIExpression()), !dbg !354
  %106 = getelementptr inbounds %struct.block, %struct.block* %96, i64 0, i32 1, !dbg !356
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !357
  call void @llvm.dbg.value(metadata i64 %99, metadata !125, metadata !DIExpression()), !dbg !359
  %107 = getelementptr inbounds %union.anon, %union.anon* %106, i64 -1, !dbg !361
  %108 = bitcast %union.anon* %107 to i8*, !dbg !361
  %109 = getelementptr inbounds i8, i8* %108, i64 %100, !dbg !362
  call void @llvm.dbg.value(metadata i8* %109, metadata !219, metadata !DIExpression()), !dbg !351
  %110 = bitcast %struct.block* %96 to i8*, !dbg !363
  %111 = icmp ult i8* %2, %110, !dbg !364
  %112 = icmp ult i8* %109, %3, !dbg !365
  %113 = select i1 %111, i1 %112, i1 false, !dbg !365
  br i1 %113, label %114, label %184, !dbg !366

114:                                              ; preds = %105
  %115 = add i64 %97, 1, !dbg !367
  call void @llvm.dbg.value(metadata i64 %115, metadata !80, metadata !DIExpression()), !dbg !88
  %116 = getelementptr inbounds %struct.block, %struct.block* %96, i64 0, i32 1, i32 0, i32 0, !dbg !368
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !84, metadata !DIExpression()), !dbg !319
  %117 = load %struct.block*, %struct.block** %116, align 8, !dbg !319, !tbaa !320
  call void @llvm.dbg.value(metadata %struct.block* %117, metadata !84, metadata !DIExpression()), !dbg !319
  %118 = icmp eq %struct.block* %117, null, !dbg !321
  br i1 %118, label %190, label %95, !dbg !323, !llvm.loop !369

119:                                              ; preds = %93, %187
  %120 = phi %struct.block* [ %150, %187 ], [ %91, %93 ]
  %121 = phi i64 [ %188, %187 ], [ %89, %93 ]
  call void @llvm.dbg.value(metadata i64 %121, metadata !80, metadata !DIExpression()), !dbg !88
  %122 = getelementptr %struct.block, %struct.block* %120, i64 0, i32 0, !dbg !327
  %123 = load i64, i64* %122, align 8, !dbg !327, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !329
  call void @llvm.dbg.value(metadata i64 %123, metadata !125, metadata !DIExpression()), !dbg !331
  %124 = and i64 %123, -16, !dbg !333
  call void @llvm.dbg.value(metadata i64 %124, metadata !334, metadata !DIExpression()), !dbg !340
  switch i64 %124, label %125 [
    i64 16, label %134
    i64 0, label %133
  ], !dbg !342

125:                                              ; preds = %119, %125
  %126 = phi i64 [ %128, %125 ], [ 1, %119 ]
  %127 = phi i64 [ %129, %125 ], [ %124, %119 ]
  call void @llvm.dbg.value(metadata i64 %126, metadata !339, metadata !DIExpression()), !dbg !340
  call void @llvm.dbg.value(metadata i64 %127, metadata !334, metadata !DIExpression()), !dbg !340
  %128 = add nuw nsw i64 %126, 1, !dbg !371
  call void @llvm.dbg.value(metadata i64 %128, metadata !339, metadata !DIExpression()), !dbg !340
  %129 = lshr i64 %127, 1, !dbg !373
  call void @llvm.dbg.value(metadata i64 %129, metadata !334, metadata !DIExpression()), !dbg !340
  %130 = icmp ugt i64 %127, 3, !dbg !374
  %131 = icmp ult i64 %126, 38, !dbg !375
  %132 = select i1 %130, i1 %131, i1 false, !dbg !375
  br i1 %132, label %125, label %134, !dbg !376, !llvm.loop !377

133:                                              ; preds = %119
  br label %134, !dbg !379

134:                                              ; preds = %125, %119, %133
  %135 = phi i64 [ 0, %119 ], [ 1, %133 ], [ %128, %125 ], !dbg !340
  %136 = icmp eq i64 %88, %135, !dbg !379
  br i1 %136, label %140, label %137, !dbg !380

137:                                              ; preds = %134, %95
  %138 = phi %struct.block* [ %96, %95 ], [ %120, %134 ]
  %139 = tail call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([72 x i8], [72 x i8]* @.str.7, i64 0, i64 0), i32 noundef %0, %struct.block* noundef nonnull %138), !dbg !381
  br label %198, !dbg !383

140:                                              ; preds = %134
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !165, metadata !DIExpression()), !dbg !343
  call void @llvm.dbg.value(metadata i64 %123, metadata !171, metadata !DIExpression()), !dbg !346
  %141 = and i64 %123, 1, !dbg !348
  %142 = icmp eq i64 %141, 0, !dbg !349
  br i1 %142, label %146, label %143, !dbg !350

143:                                              ; preds = %140, %102
  %144 = phi %struct.block* [ %96, %102 ], [ %120, %140 ]
  %145 = tail call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([61 x i8], [61 x i8]* @.str.8, i64 0, i64 0), i32 noundef %0, %struct.block* noundef nonnull %144), !dbg !384
  br label %198, !dbg !386

146:                                              ; preds = %140
  call void @llvm.dbg.value(metadata %struct.block* %120, metadata !387, metadata !DIExpression()), !dbg !392
  %147 = getelementptr inbounds %struct.block, %struct.block* %120, i64 0, i32 1, i32 0, i32 1, !dbg !394
  %148 = load %struct.block*, %struct.block** %147, align 8, !dbg !394, !tbaa !320
  call void @llvm.dbg.value(metadata %struct.block* %148, metadata !390, metadata !DIExpression()), !dbg !392
  %149 = getelementptr inbounds %struct.block, %struct.block* %120, i64 0, i32 1, i32 0, i32 0, !dbg !395
  %150 = load %struct.block*, %struct.block** %149, align 8, !dbg !395, !tbaa !320
  call void @llvm.dbg.value(metadata %struct.block* %150, metadata !391, metadata !DIExpression()), !dbg !392
  %151 = icmp eq %struct.block* %148, null, !dbg !396
  br i1 %151, label %154, label %152, !dbg !398

152:                                              ; preds = %146
  %153 = getelementptr inbounds %struct.block, %struct.block* %148, i64 0, i32 1, i32 0, i32 0, !dbg !399
  br label %158, !dbg !401

154:                                              ; preds = %146
  %155 = icmp eq %struct.block* %150, null, !dbg !402
  br i1 %155, label %173, label %156, !dbg !404

156:                                              ; preds = %154
  %157 = getelementptr inbounds %struct.block, %struct.block* %150, i64 0, i32 1, i32 0, i32 1, !dbg !405
  br label %158, !dbg !407

158:                                              ; preds = %152, %156
  %159 = phi %struct.block** [ %157, %156 ], [ %153, %152 ]
  %160 = load %struct.block*, %struct.block** %159, align 8, !dbg !392, !tbaa !320
  %161 = icmp eq %struct.block* %160, %120, !dbg !392
  br i1 %161, label %164, label %162, !dbg !408

162:                                              ; preds = %158
  %163 = tail call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([91 x i8], [91 x i8]* @.str.9, i64 0, i64 0), i32 noundef %0, %struct.block* noundef nonnull %120), !dbg !409
  br label %198, !dbg !411

164:                                              ; preds = %158
  call void @llvm.dbg.value(metadata %struct.block* %120, metadata !216, metadata !DIExpression()), !dbg !351
  call void @llvm.dbg.value(metadata i8* %2, metadata !217, metadata !DIExpression()), !dbg !351
  call void @llvm.dbg.value(metadata i8* %3, metadata !218, metadata !DIExpression()), !dbg !351
  call void @llvm.dbg.value(metadata %struct.block* %120, metadata !223, metadata !DIExpression()), !dbg !354
  %165 = getelementptr inbounds %struct.block, %struct.block* %120, i64 0, i32 1, !dbg !356
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !357
  call void @llvm.dbg.value(metadata i64 %123, metadata !125, metadata !DIExpression()), !dbg !359
  %166 = getelementptr inbounds %union.anon, %union.anon* %165, i64 -1, !dbg !361
  %167 = bitcast %union.anon* %166 to i8*, !dbg !361
  %168 = getelementptr inbounds i8, i8* %167, i64 %124, !dbg !362
  call void @llvm.dbg.value(metadata i8* %168, metadata !219, metadata !DIExpression()), !dbg !351
  %169 = bitcast %struct.block* %120 to i8*, !dbg !363
  %170 = icmp ult i8* %2, %169, !dbg !364
  %171 = icmp ult i8* %168, %3, !dbg !365
  %172 = select i1 %170, i1 %171, i1 false, !dbg !365
  br i1 %172, label %187, label %184, !dbg !366

173:                                              ; preds = %154
  call void @llvm.dbg.value(metadata %struct.block* %120, metadata !216, metadata !DIExpression()), !dbg !351
  call void @llvm.dbg.value(metadata i8* %2, metadata !217, metadata !DIExpression()), !dbg !351
  call void @llvm.dbg.value(metadata i8* %3, metadata !218, metadata !DIExpression()), !dbg !351
  call void @llvm.dbg.value(metadata %struct.block* %120, metadata !223, metadata !DIExpression()), !dbg !354
  %174 = getelementptr inbounds %struct.block, %struct.block* %120, i64 0, i32 1, !dbg !356
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !357
  call void @llvm.dbg.value(metadata i64 %123, metadata !125, metadata !DIExpression()), !dbg !359
  %175 = getelementptr inbounds %union.anon, %union.anon* %174, i64 -1, !dbg !361
  %176 = bitcast %union.anon* %175 to i8*, !dbg !361
  %177 = getelementptr inbounds i8, i8* %176, i64 %124, !dbg !362
  call void @llvm.dbg.value(metadata i8* %168, metadata !219, metadata !DIExpression()), !dbg !351
  %178 = bitcast %struct.block* %120 to i8*, !dbg !363
  %179 = icmp ult i8* %2, %178, !dbg !364
  %180 = icmp ult i8* %177, %3, !dbg !365
  %181 = select i1 %179, i1 %180, i1 false, !dbg !365
  br i1 %181, label %182, label %184, !dbg !366

182:                                              ; preds = %173
  %183 = add i64 %121, 1, !dbg !367
  call void @llvm.dbg.value(metadata i64 undef, metadata !80, metadata !DIExpression()), !dbg !88
  call void @llvm.dbg.value(metadata %struct.block* %150, metadata !84, metadata !DIExpression()), !dbg !319
  br label %190, !dbg !323

184:                                              ; preds = %173, %164, %105
  %185 = phi %struct.block* [ %96, %105 ], [ %120, %164 ], [ %120, %173 ]
  %186 = tail call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([63 x i8], [63 x i8]* @.str.10, i64 0, i64 0), i32 noundef %0, %struct.block* noundef nonnull %185), !dbg !412
  br label %198, !dbg !414

187:                                              ; preds = %164
  %188 = add i64 %121, 1, !dbg !367
  call void @llvm.dbg.value(metadata i64 %188, metadata !80, metadata !DIExpression()), !dbg !88
  call void @llvm.dbg.value(metadata %struct.block* %150, metadata !84, metadata !DIExpression()), !dbg !319
  %189 = icmp eq %struct.block* %150, null, !dbg !321
  br i1 %189, label %190, label %119, !dbg !323, !llvm.loop !369

190:                                              ; preds = %187, %114, %182, %87
  %191 = phi i64 [ %89, %87 ], [ %183, %182 ], [ %115, %114 ], [ %188, %187 ], !dbg !88
  %192 = add nuw nsw i64 %88, 1, !dbg !415
  call void @llvm.dbg.value(metadata i64 %192, metadata !82, metadata !DIExpression()), !dbg !313
  call void @llvm.dbg.value(metadata i64 %191, metadata !80, metadata !DIExpression()), !dbg !88
  %193 = icmp eq i64 %192, 40, !dbg !416
  br i1 %193, label %194, label %87, !dbg !314, !llvm.loop !417

194:                                              ; preds = %190
  call void @llvm.dbg.value(metadata i64 undef, metadata !80, metadata !DIExpression()), !dbg !88
  %195 = icmp eq i64 %79, %191, !dbg !419
  br i1 %195, label %198, label %196, !dbg !421

196:                                              ; preds = %194
  %197 = tail call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([91 x i8], [91 x i8]* @.str.11, i64 0, i64 0), i32 noundef %0, i64 noundef %191, i64 noundef %79), !dbg !422
  br label %198, !dbg !424

198:                                              ; preds = %137, %143, %162, %184, %194, %196, %85, %63, %58, %48, %38, %26, %9
  %199 = phi i1 [ false, %63 ], [ false, %58 ], [ false, %48 ], [ true, %38 ], [ false, %26 ], [ false, %196 ], [ false, %85 ], [ false, %9 ], [ true, %194 ], [ false, %184 ], [ false, %162 ], [ false, %143 ], [ false, %137 ], !dbg !88
  ret i1 %199, !dbg !425
}

declare !dbg !426 i8* @mem_heap_lo() local_unnamed_addr #1

declare !dbg !431 i8* @mem_heap_hi() local_unnamed_addr #1

; Function Attrs: nofree nounwind
declare noundef i32 @printf(i8* nocapture noundef readonly, ...) local_unnamed_addr #2

; Function Attrs: nounwind uwtable
define dso_local zeroext i1 @mm_init() local_unnamed_addr #0 !dbg !432 {
  call void @llvm.dbg.value(metadata i64 320, metadata !436, metadata !DIExpression()), !dbg !440
  %1 = tail call i8* @mem_sbrk(i64 noundef 320) #6, !dbg !441
  store i8* %1, i8** bitcast (%struct.block*** @seglists to i8**), align 8, !dbg !442, !tbaa !112
  %2 = icmp eq i8* %1, inttoptr (i64 -1 to i8*), !dbg !443
  br i1 %2, label %24, label %3, !dbg !445

3:                                                ; preds = %0
  call void @llvm.dbg.value(metadata i64 0, metadata !437, metadata !DIExpression()), !dbg !446
  call void @llvm.memset.p0i8.i64(i8* noundef nonnull align 8 dereferenceable(320) %1, i8 0, i64 320, i1 false), !dbg !447, !tbaa !112
  call void @llvm.dbg.value(metadata i32 undef, metadata !437, metadata !DIExpression()), !dbg !446
  call void @llvm.dbg.value(metadata i32 undef, metadata !437, metadata !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value)), !dbg !446
  %4 = tail call i8* @mem_sbrk(i64 noundef 16) #6, !dbg !450
  call void @llvm.dbg.value(metadata i8* %4, metadata !439, metadata !DIExpression()), !dbg !440
  %5 = icmp eq i8* %4, inttoptr (i64 -1 to i8*), !dbg !451
  br i1 %5, label %24, label %6, !dbg !453

6:                                                ; preds = %3
  call void @llvm.dbg.value(metadata i8* %4, metadata !439, metadata !DIExpression()), !dbg !440
  call void @llvm.dbg.value(metadata i64 0, metadata !454, metadata !DIExpression()), !dbg !463
  call void @llvm.dbg.value(metadata i1 true, metadata !459, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !463
  call void @llvm.dbg.value(metadata i1 false, metadata !460, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !463
  call void @llvm.dbg.value(metadata i1 false, metadata !461, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !463
  call void @llvm.dbg.value(metadata i64 0, metadata !462, metadata !DIExpression()), !dbg !463
  call void @llvm.dbg.value(metadata i64 1, metadata !462, metadata !DIExpression()), !dbg !463
  call void @llvm.dbg.value(metadata i64 1, metadata !462, metadata !DIExpression()), !dbg !463
  call void @llvm.dbg.value(metadata i64 1, metadata !462, metadata !DIExpression()), !dbg !463
  call void @llvm.dbg.value(metadata i64 0, metadata !454, metadata !DIExpression()), !dbg !465
  call void @llvm.dbg.value(metadata i1 true, metadata !459, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !465
  call void @llvm.dbg.value(metadata i1 true, metadata !460, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !465
  call void @llvm.dbg.value(metadata i1 false, metadata !461, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !465
  call void @llvm.dbg.value(metadata i64 0, metadata !462, metadata !DIExpression()), !dbg !465
  call void @llvm.dbg.value(metadata i64 1, metadata !462, metadata !DIExpression()), !dbg !465
  call void @llvm.dbg.value(metadata i64 3, metadata !462, metadata !DIExpression()), !dbg !465
  call void @llvm.dbg.value(metadata i64 3, metadata !462, metadata !DIExpression()), !dbg !465
  %7 = getelementptr inbounds i8, i8* %4, i64 8, !dbg !467
  %8 = bitcast i8* %4 to <2 x i64>*, !dbg !468
  store <2 x i64> <i64 1, i64 3>, <2 x i64>* %8, align 8, !dbg !468, !tbaa !94
  store i8* %7, i8** bitcast (%struct.block** @heap_start to i8**), align 8, !dbg !469, !tbaa !112
  call void @llvm.dbg.value(metadata i64 4096, metadata !470, metadata !DIExpression()) #6, !dbg !479
  call void @llvm.dbg.value(metadata i64 4096, metadata !470, metadata !DIExpression()) #6, !dbg !479
  %9 = tail call i8* @mem_sbrk(i64 noundef 4096) #6, !dbg !482
  call void @llvm.dbg.value(metadata i8* %9, metadata !475, metadata !DIExpression()) #6, !dbg !479
  %10 = icmp eq i8* %9, inttoptr (i64 -1 to i8*), !dbg !484
  br i1 %10, label %24, label %11, !dbg !485

11:                                               ; preds = %6
  call void @llvm.dbg.value(metadata i8* %9, metadata !486, metadata !DIExpression()) #6, !dbg !491
  %12 = getelementptr inbounds i8, i8* %9, i64 -8, !dbg !493
  %13 = bitcast i8* %12 to %struct.block*, !dbg !494
  call void @llvm.dbg.value(metadata %struct.block* %13, metadata !476, metadata !DIExpression()) #6, !dbg !479
  %14 = bitcast i8* %12 to i64*, !dbg !495
  %15 = load i64, i64* %14, align 8, !dbg !495, !tbaa !116
  call void @llvm.dbg.value(metadata i1 undef, metadata !477, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !479
  call void @llvm.dbg.value(metadata %struct.block* %13, metadata !496, metadata !DIExpression()) #6, !dbg !509
  call void @llvm.dbg.value(metadata i64 4096, metadata !501, metadata !DIExpression()) #6, !dbg !509
  call void @llvm.dbg.value(metadata i1 false, metadata !502, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !509
  call void @llvm.dbg.value(metadata i1 undef, metadata !503, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !509
  call void @llvm.dbg.value(metadata i1 undef, metadata !504, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !509
  call void @llvm.dbg.value(metadata i64 4096, metadata !454, metadata !DIExpression()) #6, !dbg !511
  call void @llvm.dbg.value(metadata i1 false, metadata !459, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !511
  call void @llvm.dbg.value(metadata i1 undef, metadata !460, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !511
  call void @llvm.dbg.value(metadata i1 undef, metadata !461, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !511
  call void @llvm.dbg.value(metadata i64 4096, metadata !462, metadata !DIExpression()) #6, !dbg !511
  call void @llvm.dbg.value(metadata i64 4096, metadata !462, metadata !DIExpression()) #6, !dbg !511
  call void @llvm.dbg.value(metadata i64 %15, metadata !462, metadata !DIExpression(DW_OP_constu, 2, DW_OP_and, DW_OP_constu, 4096, DW_OP_or, DW_OP_stack_value)) #6, !dbg !511
  %16 = and i64 %15, 6, !dbg !513
  %17 = or i64 %16, 4096, !dbg !513
  call void @llvm.dbg.value(metadata i64 %17, metadata !462, metadata !DIExpression()) #6, !dbg !511
  store i64 %17, i64* %14, align 8, !dbg !514, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* %13, metadata !223, metadata !DIExpression()) #6, !dbg !515
  %18 = getelementptr inbounds i8, i8* %9, i64 4080, !dbg !517
  %19 = bitcast i8* %18 to i64*, !dbg !518
  call void @llvm.dbg.value(metadata i64* %19, metadata !505, metadata !DIExpression()) #6, !dbg !519
  call void @llvm.dbg.value(metadata i64 4096, metadata !454, metadata !DIExpression()) #6, !dbg !520
  call void @llvm.dbg.value(metadata i1 false, metadata !459, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !520
  call void @llvm.dbg.value(metadata i1 undef, metadata !460, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !520
  call void @llvm.dbg.value(metadata i1 undef, metadata !461, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !520
  call void @llvm.dbg.value(metadata i64 4096, metadata !462, metadata !DIExpression()) #6, !dbg !520
  call void @llvm.dbg.value(metadata i64 4096, metadata !462, metadata !DIExpression()) #6, !dbg !520
  call void @llvm.dbg.value(metadata i64 %15, metadata !462, metadata !DIExpression(DW_OP_constu, 2, DW_OP_and, DW_OP_constu, 4096, DW_OP_or, DW_OP_stack_value)) #6, !dbg !520
  call void @llvm.dbg.value(metadata i64 %17, metadata !462, metadata !DIExpression()) #6, !dbg !520
  store i64 %17, i64* %19, align 8, !dbg !522, !tbaa !94
  call void @llvm.dbg.value(metadata %struct.block* %13, metadata !181, metadata !DIExpression()) #6, !dbg !523
  call void @llvm.dbg.value(metadata %struct.block* %13, metadata !181, metadata !DIExpression()) #6, !dbg !525
  %20 = getelementptr inbounds i8, i8* %9, i64 4088, !dbg !527
  call void @llvm.dbg.value(metadata i8* %20, metadata !478, metadata !DIExpression()) #6, !dbg !479
  call void @llvm.dbg.value(metadata i8* %20, metadata !528, metadata !DIExpression()) #6, !dbg !533
  %21 = bitcast i8* %20 to i64*, !dbg !535
  call void @llvm.dbg.value(metadata i64 0, metadata !454, metadata !DIExpression()) #6, !dbg !536
  call void @llvm.dbg.value(metadata i1 true, metadata !459, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !536
  call void @llvm.dbg.value(metadata i1 undef, metadata !460, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !536
  call void @llvm.dbg.value(metadata i1 undef, metadata !461, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !536
  call void @llvm.dbg.value(metadata i64 0, metadata !462, metadata !DIExpression()) #6, !dbg !536
  call void @llvm.dbg.value(metadata i64 1, metadata !462, metadata !DIExpression()) #6, !dbg !536
  call void @llvm.dbg.value(metadata i64 undef, metadata !462, metadata !DIExpression(DW_OP_constu, 18446744073709551609, DW_OP_and, DW_OP_constu, 2, DW_OP_and, DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)) #6, !dbg !536
  call void @llvm.dbg.value(metadata i64 1, metadata !462, metadata !DIExpression()) #6, !dbg !536
  store i64 1, i64* %21, align 8, !dbg !538, !tbaa !116
  %22 = tail call fastcc %struct.block* @coalesce_block(%struct.block* noundef nonnull %13) #6, !dbg !539
  call void @llvm.dbg.value(metadata %struct.block* %22, metadata !476, metadata !DIExpression()) #6, !dbg !479
  %23 = icmp ne %struct.block* %22, null
  br label %24

24:                                               ; preds = %11, %6, %3, %0
  %25 = phi i1 [ false, %0 ], [ false, %3 ], [ %23, %11 ], [ false, %6 ], !dbg !440
  ret i1 %25, !dbg !540
}

declare !dbg !541 i8* @mem_sbrk(i64 noundef) local_unnamed_addr #1

; Function Attrs: nounwind uwtable
define dso_local i8* @mm_malloc(i64 noundef %0) local_unnamed_addr #0 !dbg !544 {
  call void @llvm.dbg.value(metadata i64 %0, metadata !548, metadata !DIExpression()), !dbg !555
  call void @llvm.dbg.value(metadata i8* null, metadata !552, metadata !DIExpression()), !dbg !555
  %2 = load %struct.block*, %struct.block** @heap_start, align 8, !dbg !556, !tbaa !112
  %3 = icmp eq %struct.block* %2, null, !dbg !558
  br i1 %3, label %4, label %30, !dbg !559

4:                                                ; preds = %1
  call void @llvm.dbg.value(metadata i64 320, metadata !436, metadata !DIExpression()) #6, !dbg !560
  %5 = tail call i8* @mem_sbrk(i64 noundef 320) #6, !dbg !564
  store i8* %5, i8** bitcast (%struct.block*** @seglists to i8**), align 8, !dbg !565, !tbaa !112
  %6 = icmp eq i8* %5, inttoptr (i64 -1 to i8*), !dbg !566
  br i1 %6, label %297, label %7, !dbg !567

7:                                                ; preds = %4
  call void @llvm.dbg.value(metadata i64 0, metadata !437, metadata !DIExpression()) #6, !dbg !568
  tail call void @llvm.memset.p0i8.i64(i8* noundef nonnull align 8 dereferenceable(320) %5, i8 0, i64 320, i1 false) #6, !dbg !569, !tbaa !112
  call void @llvm.dbg.value(metadata i32 undef, metadata !437, metadata !DIExpression()) #6, !dbg !568
  call void @llvm.dbg.value(metadata i32 undef, metadata !437, metadata !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value)) #6, !dbg !568
  %8 = tail call i8* @mem_sbrk(i64 noundef 16) #6, !dbg !570
  call void @llvm.dbg.value(metadata i8* %8, metadata !439, metadata !DIExpression()) #6, !dbg !560
  %9 = icmp eq i8* %8, inttoptr (i64 -1 to i8*), !dbg !571
  br i1 %9, label %297, label %10, !dbg !572

10:                                               ; preds = %7
  call void @llvm.dbg.value(metadata i8* %8, metadata !439, metadata !DIExpression()) #6, !dbg !560
  call void @llvm.dbg.value(metadata i64 0, metadata !454, metadata !DIExpression()) #6, !dbg !573
  call void @llvm.dbg.value(metadata i1 true, metadata !459, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !573
  call void @llvm.dbg.value(metadata i1 false, metadata !460, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !573
  call void @llvm.dbg.value(metadata i1 false, metadata !461, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !573
  call void @llvm.dbg.value(metadata i64 0, metadata !462, metadata !DIExpression()) #6, !dbg !573
  call void @llvm.dbg.value(metadata i64 1, metadata !462, metadata !DIExpression()) #6, !dbg !573
  call void @llvm.dbg.value(metadata i64 1, metadata !462, metadata !DIExpression()) #6, !dbg !573
  call void @llvm.dbg.value(metadata i64 1, metadata !462, metadata !DIExpression()) #6, !dbg !573
  call void @llvm.dbg.value(metadata i64 0, metadata !454, metadata !DIExpression()) #6, !dbg !575
  call void @llvm.dbg.value(metadata i1 true, metadata !459, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !575
  call void @llvm.dbg.value(metadata i1 true, metadata !460, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !575
  call void @llvm.dbg.value(metadata i1 false, metadata !461, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !575
  call void @llvm.dbg.value(metadata i64 0, metadata !462, metadata !DIExpression()) #6, !dbg !575
  call void @llvm.dbg.value(metadata i64 1, metadata !462, metadata !DIExpression()) #6, !dbg !575
  call void @llvm.dbg.value(metadata i64 3, metadata !462, metadata !DIExpression()) #6, !dbg !575
  call void @llvm.dbg.value(metadata i64 3, metadata !462, metadata !DIExpression()) #6, !dbg !575
  %11 = getelementptr inbounds i8, i8* %8, i64 8, !dbg !577
  %12 = bitcast i8* %8 to <2 x i64>*, !dbg !578
  store <2 x i64> <i64 1, i64 3>, <2 x i64>* %12, align 8, !dbg !578, !tbaa !94
  store i8* %11, i8** bitcast (%struct.block** @heap_start to i8**), align 8, !dbg !579, !tbaa !112
  call void @llvm.dbg.value(metadata i64 4096, metadata !470, metadata !DIExpression()) #6, !dbg !580
  call void @llvm.dbg.value(metadata i64 4096, metadata !470, metadata !DIExpression()) #6, !dbg !580
  %13 = tail call i8* @mem_sbrk(i64 noundef 4096) #6, !dbg !582
  call void @llvm.dbg.value(metadata i8* %13, metadata !475, metadata !DIExpression()) #6, !dbg !580
  %14 = icmp eq i8* %13, inttoptr (i64 -1 to i8*), !dbg !583
  br i1 %14, label %297, label %15, !dbg !584

15:                                               ; preds = %10
  call void @llvm.dbg.value(metadata i8* %13, metadata !486, metadata !DIExpression()) #6, !dbg !585
  %16 = getelementptr inbounds i8, i8* %13, i64 -8, !dbg !587
  %17 = bitcast i8* %16 to %struct.block*, !dbg !588
  call void @llvm.dbg.value(metadata %struct.block* %17, metadata !476, metadata !DIExpression()) #6, !dbg !580
  %18 = bitcast i8* %16 to i64*, !dbg !589
  %19 = load i64, i64* %18, align 8, !dbg !589, !tbaa !116
  call void @llvm.dbg.value(metadata i1 undef, metadata !477, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !580
  call void @llvm.dbg.value(metadata %struct.block* %17, metadata !496, metadata !DIExpression()) #6, !dbg !590
  call void @llvm.dbg.value(metadata i64 4096, metadata !501, metadata !DIExpression()) #6, !dbg !590
  call void @llvm.dbg.value(metadata i1 false, metadata !502, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !590
  call void @llvm.dbg.value(metadata i1 undef, metadata !503, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !590
  call void @llvm.dbg.value(metadata i1 undef, metadata !504, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !590
  call void @llvm.dbg.value(metadata i64 4096, metadata !454, metadata !DIExpression()) #6, !dbg !592
  call void @llvm.dbg.value(metadata i1 false, metadata !459, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !592
  call void @llvm.dbg.value(metadata i1 undef, metadata !460, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !592
  call void @llvm.dbg.value(metadata i1 undef, metadata !461, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !592
  call void @llvm.dbg.value(metadata i64 %19, metadata !462, metadata !DIExpression(DW_OP_constu, 2, DW_OP_and, DW_OP_constu, 4096, DW_OP_or, DW_OP_stack_value)) #6, !dbg !592
  %20 = and i64 %19, 6, !dbg !594
  %21 = or i64 %20, 4096, !dbg !594
  call void @llvm.dbg.value(metadata i64 %21, metadata !462, metadata !DIExpression()) #6, !dbg !592
  store i64 %21, i64* %18, align 8, !dbg !595, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* %17, metadata !223, metadata !DIExpression()) #6, !dbg !596
  %22 = getelementptr inbounds i8, i8* %13, i64 4080, !dbg !598
  %23 = bitcast i8* %22 to i64*, !dbg !599
  call void @llvm.dbg.value(metadata i64* %23, metadata !505, metadata !DIExpression()) #6, !dbg !600
  call void @llvm.dbg.value(metadata i64 4096, metadata !454, metadata !DIExpression()) #6, !dbg !601
  call void @llvm.dbg.value(metadata i1 false, metadata !459, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !601
  call void @llvm.dbg.value(metadata i1 undef, metadata !460, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !601
  call void @llvm.dbg.value(metadata i1 undef, metadata !461, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !601
  call void @llvm.dbg.value(metadata i64 %21, metadata !462, metadata !DIExpression()) #6, !dbg !601
  store i64 %21, i64* %23, align 8, !dbg !603, !tbaa !94
  call void @llvm.dbg.value(metadata %struct.block* %17, metadata !181, metadata !DIExpression()) #6, !dbg !604
  call void @llvm.dbg.value(metadata %struct.block* %17, metadata !181, metadata !DIExpression()) #6, !dbg !606
  %24 = getelementptr inbounds i8, i8* %13, i64 4088, !dbg !608
  call void @llvm.dbg.value(metadata i8* %24, metadata !478, metadata !DIExpression()) #6, !dbg !580
  call void @llvm.dbg.value(metadata i8* %24, metadata !528, metadata !DIExpression()) #6, !dbg !609
  %25 = bitcast i8* %24 to i64*, !dbg !611
  call void @llvm.dbg.value(metadata i64 0, metadata !454, metadata !DIExpression()) #6, !dbg !612
  call void @llvm.dbg.value(metadata i1 true, metadata !459, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !612
  call void @llvm.dbg.value(metadata i1 undef, metadata !460, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !612
  call void @llvm.dbg.value(metadata i1 undef, metadata !461, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !612
  call void @llvm.dbg.value(metadata i64 1, metadata !462, metadata !DIExpression()) #6, !dbg !612
  store i64 1, i64* %25, align 8, !dbg !614, !tbaa !116
  %26 = tail call fastcc %struct.block* @coalesce_block(%struct.block* noundef nonnull %17) #6, !dbg !615
  call void @llvm.dbg.value(metadata %struct.block* %26, metadata !476, metadata !DIExpression()) #6, !dbg !580
  %27 = icmp eq %struct.block* %26, null
  %28 = icmp eq i64 %0, 0
  %29 = or i1 %28, %27, !dbg !616
  br i1 %29, label %297, label %32, !dbg !616

30:                                               ; preds = %1
  %31 = icmp eq i64 %0, 0, !dbg !617
  br i1 %31, label %297, label %32, !dbg !619

32:                                               ; preds = %15, %30
  %33 = icmp ult i64 %0, 9, !dbg !620
  br i1 %33, label %47, label %34, !dbg !622

34:                                               ; preds = %32
  call void @llvm.dbg.value(metadata i64 %0, metadata !623, metadata !DIExpression(DW_OP_plus_uconst, 8, DW_OP_stack_value)), !dbg !629
  call void @llvm.dbg.value(metadata i64 16, metadata !628, metadata !DIExpression()), !dbg !629
  %35 = add i64 %0, 23, !dbg !632
  %36 = and i64 %35, -16, !dbg !633
  call void @llvm.dbg.value(metadata i64 %36, metadata !549, metadata !DIExpression()), !dbg !555
  call void @llvm.dbg.value(metadata i64 %36, metadata !634, metadata !DIExpression()), !dbg !638
  call void @llvm.dbg.value(metadata i64 32, metadata !637, metadata !DIExpression()), !dbg !638
  %37 = icmp ugt i64 %36, 32, !dbg !640
  call void @llvm.dbg.value(metadata i64 undef, metadata !549, metadata !DIExpression()), !dbg !555
  %38 = select i1 %37, i64 %36, i64 32
  call void @llvm.dbg.value(metadata i64 undef, metadata !549, metadata !DIExpression()), !dbg !555
  call void @llvm.dbg.value(metadata i64 undef, metadata !641, metadata !DIExpression()), !dbg !651
  call void @llvm.dbg.value(metadata %struct.block* null, metadata !645, metadata !DIExpression()), !dbg !651
  call void @llvm.dbg.value(metadata i64 -1, metadata !647, metadata !DIExpression()), !dbg !651
  call void @llvm.dbg.value(metadata i64 1, metadata !339, metadata !DIExpression()), !dbg !653
  call void @llvm.dbg.value(metadata i64 undef, metadata !334, metadata !DIExpression()), !dbg !653
  br label %39

39:                                               ; preds = %39, %34
  %40 = phi i64 [ %42, %39 ], [ 1, %34 ]
  %41 = phi i64 [ %43, %39 ], [ %38, %34 ]
  call void @llvm.dbg.value(metadata i64 %40, metadata !339, metadata !DIExpression()), !dbg !653
  call void @llvm.dbg.value(metadata i64 %41, metadata !334, metadata !DIExpression()), !dbg !653
  %42 = add nuw nsw i64 %40, 1, !dbg !655
  call void @llvm.dbg.value(metadata i64 %42, metadata !339, metadata !DIExpression()), !dbg !653
  %43 = lshr i64 %41, 1, !dbg !656
  call void @llvm.dbg.value(metadata i64 %43, metadata !334, metadata !DIExpression()), !dbg !653
  %44 = icmp ugt i64 %41, 3, !dbg !657
  %45 = icmp ult i64 %40, 38, !dbg !658
  %46 = select i1 %44, i1 %45, i1 false, !dbg !658
  br i1 %46, label %39, label %47, !dbg !659, !llvm.loop !660

47:                                               ; preds = %39, %32
  %48 = phi i64 [ 16, %32 ], [ %38, %39 ]
  %49 = phi i64 [ 0, %32 ], [ %42, %39 ], !dbg !653
  call void @llvm.dbg.value(metadata i64 %49, metadata !648, metadata !DIExpression()), !dbg !651
  call void @llvm.dbg.value(metadata i64 %49, metadata !649, metadata !DIExpression()), !dbg !662
  call void @llvm.dbg.value(metadata i64 -1, metadata !647, metadata !DIExpression()), !dbg !651
  call void @llvm.dbg.value(metadata %struct.block* null, metadata !645, metadata !DIExpression()), !dbg !651
  %50 = load %struct.block**, %struct.block*** @seglists, align 8, !tbaa !112
  br label %55, !dbg !663

51:                                               ; preds = %55, %81
  %52 = phi i64 [ %77, %81 ], [ %57, %55 ]
  %53 = add nuw nsw i64 %56, 1, !dbg !664
  call void @llvm.dbg.value(metadata i64 %56, metadata !649, metadata !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value)), !dbg !662
  call void @llvm.dbg.value(metadata i64 %77, metadata !647, metadata !DIExpression()), !dbg !651
  call void @llvm.dbg.value(metadata %struct.block* null, metadata !645, metadata !DIExpression()), !dbg !651
  %54 = icmp eq i64 %53, 40, !dbg !666
  br i1 %54, label %83, label %55, !dbg !663, !llvm.loop !667

55:                                               ; preds = %51, %47
  %56 = phi i64 [ %49, %47 ], [ %53, %51 ]
  %57 = phi i64 [ -1, %47 ], [ %52, %51 ]
  call void @llvm.dbg.value(metadata i64 %56, metadata !649, metadata !DIExpression()), !dbg !662
  call void @llvm.dbg.value(metadata i64 %57, metadata !647, metadata !DIExpression()), !dbg !651
  %58 = getelementptr inbounds %struct.block*, %struct.block** %50, i64 %56, !dbg !669
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !644, metadata !DIExpression()), !dbg !651
  %59 = load %struct.block*, %struct.block** %58, align 8, !dbg !672, !tbaa !320
  call void @llvm.dbg.value(metadata %struct.block* %59, metadata !644, metadata !DIExpression()), !dbg !651
  call void @llvm.dbg.value(metadata %struct.block* null, metadata !645, metadata !DIExpression()), !dbg !651
  %60 = icmp eq %struct.block* %59, null, !dbg !673
  br i1 %60, label %51, label %61, !dbg !675

61:                                               ; preds = %55, %75
  %62 = phi %struct.block* [ %79, %75 ], [ %59, %55 ]
  %63 = phi i64 [ %77, %75 ], [ %57, %55 ]
  %64 = phi %struct.block* [ %76, %75 ], [ null, %55 ]
  call void @llvm.dbg.value(metadata i64 %63, metadata !647, metadata !DIExpression()), !dbg !651
  call void @llvm.dbg.value(metadata %struct.block* %64, metadata !645, metadata !DIExpression()), !dbg !651
  %65 = getelementptr %struct.block, %struct.block* %62, i64 0, i32 0, !dbg !676
  %66 = load i64, i64* %65, align 8, !dbg !676, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !678
  call void @llvm.dbg.value(metadata i64 %66, metadata !125, metadata !DIExpression()), !dbg !680
  %67 = and i64 %66, -16, !dbg !682
  call void @llvm.dbg.value(metadata i64 %67, metadata !646, metadata !DIExpression()), !dbg !651
  %68 = icmp ult i64 %67, %48, !dbg !683
  br i1 %68, label %75, label %69, !dbg !685

69:                                               ; preds = %61
  %70 = icmp eq i64 %67, %48, !dbg !686
  br i1 %70, label %127, label %71, !dbg !689

71:                                               ; preds = %69
  %72 = icmp ult i64 %67, %63, !dbg !690
  %73 = select i1 %72, %struct.block* %62, %struct.block* %64, !dbg !693
  %74 = select i1 %72, i64 %67, i64 %63, !dbg !693
  br label %75, !dbg !693

75:                                               ; preds = %71, %61
  %76 = phi %struct.block* [ %64, %61 ], [ %73, %71 ], !dbg !651
  %77 = phi i64 [ %63, %61 ], [ %74, %71 ], !dbg !651
  call void @llvm.dbg.value(metadata i64 %77, metadata !647, metadata !DIExpression()), !dbg !651
  call void @llvm.dbg.value(metadata %struct.block* %76, metadata !645, metadata !DIExpression()), !dbg !651
  %78 = getelementptr inbounds %struct.block, %struct.block* %62, i64 0, i32 1, i32 0, i32 0, !dbg !694
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !644, metadata !DIExpression()), !dbg !651
  %79 = load %struct.block*, %struct.block** %78, align 8, !dbg !672, !tbaa !320
  call void @llvm.dbg.value(metadata %struct.block* %79, metadata !644, metadata !DIExpression()), !dbg !651
  %80 = icmp eq %struct.block* %79, null, !dbg !673
  br i1 %80, label %81, label %61, !dbg !675, !llvm.loop !695

81:                                               ; preds = %75
  %82 = icmp eq %struct.block* %76, null, !dbg !697
  call void @llvm.dbg.value(metadata i64 %56, metadata !649, metadata !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value)), !dbg !662
  br i1 %82, label %51, label %127, !dbg !699

83:                                               ; preds = %51
  call void @llvm.dbg.value(metadata %struct.block* null, metadata !551, metadata !DIExpression()), !dbg !555
  call void @llvm.dbg.value(metadata i64 undef, metadata !634, metadata !DIExpression()), !dbg !700
  call void @llvm.dbg.value(metadata i64 4096, metadata !637, metadata !DIExpression()), !dbg !700
  %84 = icmp ugt i64 %48, 4096, !dbg !704
  %85 = select i1 %84, i64 %48, i64 4096, !dbg !705
  call void @llvm.dbg.value(metadata i64 %85, metadata !550, metadata !DIExpression()), !dbg !555
  call void @llvm.dbg.value(metadata i64 %85, metadata !470, metadata !DIExpression()) #6, !dbg !706
  call void @llvm.dbg.value(metadata i64 %85, metadata !623, metadata !DIExpression()) #6, !dbg !708
  call void @llvm.dbg.value(metadata i64 16, metadata !628, metadata !DIExpression()) #6, !dbg !708
  %86 = add i64 %85, 15, !dbg !710
  %87 = and i64 %86, -16, !dbg !711
  call void @llvm.dbg.value(metadata i64 %87, metadata !470, metadata !DIExpression()) #6, !dbg !706
  %88 = tail call i8* @mem_sbrk(i64 noundef %87) #6, !dbg !712
  call void @llvm.dbg.value(metadata i8* %88, metadata !475, metadata !DIExpression()) #6, !dbg !706
  %89 = icmp eq i8* %88, inttoptr (i64 -1 to i8*), !dbg !713
  br i1 %89, label %297, label %90, !dbg !714

90:                                               ; preds = %83
  call void @llvm.dbg.value(metadata i8* %88, metadata !486, metadata !DIExpression()) #6, !dbg !715
  %91 = getelementptr inbounds i8, i8* %88, i64 -8, !dbg !717
  %92 = bitcast i8* %91 to %struct.block*, !dbg !718
  call void @llvm.dbg.value(metadata %struct.block* %92, metadata !476, metadata !DIExpression()) #6, !dbg !706
  %93 = bitcast i8* %91 to i64*, !dbg !719
  %94 = load i64, i64* %93, align 8, !dbg !719, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !720, metadata !DIExpression()) #6, !dbg !723
  call void @llvm.dbg.value(metadata i64 %94, metadata !725, metadata !DIExpression()) #6, !dbg !728
  %95 = and i64 %94, 2, !dbg !730
  call void @llvm.dbg.value(metadata i1 undef, metadata !477, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !706
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !731, metadata !DIExpression()) #6, !dbg !734
  call void @llvm.dbg.value(metadata i64 %94, metadata !736, metadata !DIExpression()) #6, !dbg !739
  %96 = and i64 %94, 4, !dbg !741
  call void @llvm.dbg.value(metadata %struct.block* %92, metadata !496, metadata !DIExpression()) #6, !dbg !742
  call void @llvm.dbg.value(metadata i64 %87, metadata !501, metadata !DIExpression()) #6, !dbg !742
  call void @llvm.dbg.value(metadata i1 false, metadata !502, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !742
  call void @llvm.dbg.value(metadata i1 undef, metadata !503, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !742
  call void @llvm.dbg.value(metadata i1 undef, metadata !504, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !742
  call void @llvm.dbg.value(metadata i64 %87, metadata !454, metadata !DIExpression()) #6, !dbg !744
  call void @llvm.dbg.value(metadata i1 false, metadata !459, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !744
  call void @llvm.dbg.value(metadata i1 undef, metadata !460, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !744
  call void @llvm.dbg.value(metadata i1 undef, metadata !461, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !744
  call void @llvm.dbg.value(metadata i64 %87, metadata !462, metadata !DIExpression()) #6, !dbg !744
  %97 = or i64 %95, %87, !dbg !746
  call void @llvm.dbg.value(metadata i64 %97, metadata !462, metadata !DIExpression()) #6, !dbg !744
  %98 = or i64 %97, %96, !dbg !747
  call void @llvm.dbg.value(metadata i64 %98, metadata !462, metadata !DIExpression()) #6, !dbg !744
  store i64 %98, i64* %93, align 8, !dbg !748, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !251, metadata !DIExpression()) #6, !dbg !749
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()) #6, !dbg !751
  call void @llvm.dbg.value(metadata i64 %98, metadata !125, metadata !DIExpression()) #6, !dbg !753
  %99 = icmp eq i64 %87, 16, !dbg !755
  br i1 %99, label %106, label %100, !dbg !756

100:                                              ; preds = %90
  call void @llvm.dbg.value(metadata %struct.block* %92, metadata !223, metadata !DIExpression()) #6, !dbg !757
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()) #6, !dbg !759
  call void @llvm.dbg.value(metadata i64 %98, metadata !125, metadata !DIExpression()) #6, !dbg !761
  %101 = getelementptr inbounds i8, i8* %88, i64 %87, !dbg !763
  %102 = getelementptr inbounds i8, i8* %101, i64 -16, !dbg !764
  %103 = bitcast i8* %102 to i64*, !dbg !765
  call void @llvm.dbg.value(metadata i64* %103, metadata !505, metadata !DIExpression()) #6, !dbg !766
  call void @llvm.dbg.value(metadata i64 %87, metadata !454, metadata !DIExpression()) #6, !dbg !767
  call void @llvm.dbg.value(metadata i1 false, metadata !459, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !767
  call void @llvm.dbg.value(metadata i1 undef, metadata !460, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !767
  call void @llvm.dbg.value(metadata i1 undef, metadata !461, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !767
  call void @llvm.dbg.value(metadata i64 %98, metadata !462, metadata !DIExpression()) #6, !dbg !767
  store i64 %98, i64* %103, align 8, !dbg !769, !tbaa !94
  %104 = load i64, i64* %93, align 8, !dbg !770, !tbaa !116
  %105 = and i64 %104, -16, !dbg !772
  br label %106, !dbg !775

106:                                              ; preds = %90, %100
  %107 = phi i64 [ %105, %100 ], [ 16, %90 ], !dbg !772
  call void @llvm.dbg.value(metadata %struct.block* %92, metadata !181, metadata !DIExpression()) #6, !dbg !776
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()) #6, !dbg !777
  call void @llvm.dbg.value(metadata i64 %98, metadata !125, metadata !DIExpression()) #6, !dbg !778
  %108 = getelementptr inbounds i8, i8* %91, i64 %107, !dbg !779
  %109 = bitcast i8* %108 to i64*, !dbg !780
  %110 = load i64, i64* %109, align 8, !dbg !783, !tbaa !116
  %111 = and i64 %110, -3, !dbg !783
  store i64 %111, i64* %109, align 8, !dbg !783, !tbaa !116
  %112 = load i64, i64* %93, align 8, !dbg !784, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !251, metadata !DIExpression()) #6, !dbg !786
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()) #6, !dbg !788
  call void @llvm.dbg.value(metadata i64 %112, metadata !125, metadata !DIExpression()) #6, !dbg !790
  %113 = and i64 %112, -16, !dbg !792
  %114 = icmp eq i64 %113, 16, !dbg !793
  %115 = and i64 %110, -7, !dbg !794
  %116 = select i1 %114, i64 4, i64 0, !dbg !794
  %117 = or i64 %116, %115, !dbg !794
  store i64 %117, i64* %109, align 8, !dbg !795, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* %92, metadata !181, metadata !DIExpression()) #6, !dbg !796
  %118 = load i64, i64* %93, align 8, !dbg !798, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()) #6, !dbg !799
  call void @llvm.dbg.value(metadata i64 %118, metadata !125, metadata !DIExpression()) #6, !dbg !801
  %119 = and i64 %118, -16, !dbg !803
  %120 = getelementptr inbounds i8, i8* %91, i64 %119, !dbg !804
  call void @llvm.dbg.value(metadata i8* %120, metadata !478, metadata !DIExpression()) #6, !dbg !706
  call void @llvm.dbg.value(metadata i8* %120, metadata !528, metadata !DIExpression()) #6, !dbg !805
  %121 = bitcast i8* %120 to i64*, !dbg !807
  %122 = load i64, i64* %121, align 8, !dbg !807, !tbaa !116
  call void @llvm.dbg.value(metadata i64 0, metadata !454, metadata !DIExpression()) #6, !dbg !808
  call void @llvm.dbg.value(metadata i1 true, metadata !459, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !808
  call void @llvm.dbg.value(metadata i1 undef, metadata !460, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !808
  call void @llvm.dbg.value(metadata i1 undef, metadata !461, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)) #6, !dbg !808
  call void @llvm.dbg.value(metadata i64 %122, metadata !462, metadata !DIExpression(DW_OP_constu, 2, DW_OP_and, DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)) #6, !dbg !808
  %123 = and i64 %122, 6, !dbg !810
  %124 = or i64 %123, 1, !dbg !810
  call void @llvm.dbg.value(metadata i64 %124, metadata !462, metadata !DIExpression()) #6, !dbg !808
  store i64 %124, i64* %121, align 8, !dbg !811, !tbaa !116
  %125 = tail call fastcc %struct.block* @coalesce_block(%struct.block* noundef nonnull %92) #6, !dbg !812
  call void @llvm.dbg.value(metadata %struct.block* %125, metadata !476, metadata !DIExpression()) #6, !dbg !706
  call void @llvm.dbg.value(metadata %struct.block* %125, metadata !551, metadata !DIExpression()), !dbg !555
  %126 = icmp eq %struct.block* %125, null, !dbg !813
  br i1 %126, label %297, label %127, !dbg !815

127:                                              ; preds = %81, %69, %106
  %128 = phi %struct.block* [ %125, %106 ], [ %62, %69 ], [ %76, %81 ], !dbg !555
  call void @llvm.dbg.value(metadata %struct.block* %128, metadata !551, metadata !DIExpression()), !dbg !555
  %129 = getelementptr %struct.block, %struct.block* %128, i64 0, i32 0, !dbg !816
  %130 = load i64, i64* %129, align 8, !dbg !816, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !720, metadata !DIExpression()), !dbg !817
  call void @llvm.dbg.value(metadata i64 %130, metadata !725, metadata !DIExpression()), !dbg !819
  %131 = and i64 %130, 2, !dbg !821
  call void @llvm.dbg.value(metadata i1 undef, metadata !553, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !555
  call void @llvm.dbg.value(metadata %struct.block* %128, metadata !822, metadata !DIExpression()), !dbg !832
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !834
  call void @llvm.dbg.value(metadata i64 %130, metadata !125, metadata !DIExpression()), !dbg !836
  %132 = and i64 %130, -16, !dbg !838
  call void @llvm.dbg.value(metadata i64 %132, metadata !334, metadata !DIExpression()), !dbg !839
  switch i64 %132, label %133 [
    i64 16, label %141
    i64 0, label %168
  ], !dbg !841

133:                                              ; preds = %127, %133
  %134 = phi i64 [ %136, %133 ], [ 1, %127 ]
  %135 = phi i64 [ %137, %133 ], [ %132, %127 ]
  call void @llvm.dbg.value(metadata i64 %134, metadata !339, metadata !DIExpression()), !dbg !839
  call void @llvm.dbg.value(metadata i64 %135, metadata !334, metadata !DIExpression()), !dbg !839
  %136 = add nuw nsw i64 %134, 1, !dbg !842
  call void @llvm.dbg.value(metadata i64 %136, metadata !339, metadata !DIExpression()), !dbg !839
  %137 = lshr i64 %135, 1, !dbg !843
  call void @llvm.dbg.value(metadata i64 %137, metadata !334, metadata !DIExpression()), !dbg !839
  %138 = icmp ugt i64 %135, 3, !dbg !844
  %139 = icmp ult i64 %134, 38, !dbg !845
  %140 = select i1 %138, i1 %139, i1 false, !dbg !845
  br i1 %140, label %133, label %168, !dbg !846, !llvm.loop !847

141:                                              ; preds = %127
  call void @llvm.dbg.value(metadata %struct.block* null, metadata !826, metadata !DIExpression()), !dbg !849
  %142 = load %struct.block**, %struct.block*** @seglists, align 8, !dbg !850, !tbaa !112
  %143 = load %struct.block*, %struct.block** %142, align 8, !dbg !850, !tbaa !112
  call void @llvm.dbg.value(metadata %struct.block* %143, metadata !829, metadata !DIExpression()), !dbg !849
  %144 = icmp ne %struct.block* %143, null, !dbg !851
  %145 = icmp eq %struct.block* %143, %128
  %146 = and i1 %144, %145, !dbg !853
  br i1 %146, label %150, label %147, !dbg !853

147:                                              ; preds = %141
  call void @llvm.dbg.value(metadata %struct.block* null, metadata !826, metadata !DIExpression()), !dbg !849
  call void @llvm.dbg.value(metadata %struct.block* %143, metadata !829, metadata !DIExpression()), !dbg !849
  %148 = icmp ne %struct.block* %143, %128, !dbg !854
  %149 = and i1 %144, %148, !dbg !854
  br i1 %149, label %153, label %160, !dbg !855

150:                                              ; preds = %141
  %151 = getelementptr inbounds %struct.block, %struct.block* %128, i64 0, i32 1, i32 0, i32 0, !dbg !856
  %152 = load %struct.block*, %struct.block** %151, align 8, !dbg !856, !tbaa !320
  store %struct.block* %152, %struct.block** %142, align 8, !dbg !858, !tbaa !112
  br label %182, !dbg !859

153:                                              ; preds = %147, %153
  %154 = phi %struct.block* [ %156, %153 ], [ %143, %147 ]
  call void @llvm.dbg.value(metadata %struct.block* %154, metadata !829, metadata !DIExpression()), !dbg !849
  call void @llvm.dbg.value(metadata %struct.block* %154, metadata !826, metadata !DIExpression()), !dbg !849
  %155 = getelementptr inbounds %struct.block, %struct.block* %154, i64 0, i32 1, i32 0, i32 0, !dbg !860
  %156 = load %struct.block*, %struct.block** %155, align 8, !dbg !860, !tbaa !320
  call void @llvm.dbg.value(metadata %struct.block* %156, metadata !829, metadata !DIExpression()), !dbg !849
  %157 = icmp ne %struct.block* %156, null, !dbg !862
  %158 = icmp ne %struct.block* %156, %128, !dbg !854
  %159 = and i1 %157, %158, !dbg !854
  br i1 %159, label %153, label %160, !dbg !855, !llvm.loop !863

160:                                              ; preds = %153, %147
  %161 = phi %struct.block* [ %143, %147 ], [ %156, %153 ], !dbg !849
  %162 = phi %struct.block* [ null, %147 ], [ %154, %153 ], !dbg !849
  %163 = icmp eq %struct.block* %161, null, !dbg !865
  br i1 %163, label %182, label %164, !dbg !867

164:                                              ; preds = %160
  %165 = getelementptr inbounds %struct.block, %struct.block* %161, i64 0, i32 1, i32 0, i32 0, !dbg !868
  %166 = load %struct.block*, %struct.block** %165, align 8, !dbg !868, !tbaa !320
  %167 = getelementptr inbounds %struct.block, %struct.block* %162, i64 0, i32 1, i32 0, i32 0, !dbg !869
  store %struct.block* %166, %struct.block** %167, align 8, !dbg !870, !tbaa !320
  br label %182, !dbg !871

168:                                              ; preds = %133, %127
  %169 = phi i64 [ 1, %127 ], [ %136, %133 ]
  %170 = getelementptr inbounds %struct.block, %struct.block* %128, i64 0, i32 1, i32 0, i32 1, !dbg !872
  %171 = load %struct.block*, %struct.block** %170, align 8, !dbg !872, !tbaa !320
  call void @llvm.dbg.value(metadata %struct.block* %171, metadata !830, metadata !DIExpression()), !dbg !832
  %172 = getelementptr inbounds %struct.block, %struct.block* %128, i64 0, i32 1, i32 0, i32 0, !dbg !873
  %173 = load %struct.block*, %struct.block** %172, align 8, !dbg !873, !tbaa !320
  call void @llvm.dbg.value(metadata %struct.block* %173, metadata !831, metadata !DIExpression()), !dbg !832
  %174 = icmp eq %struct.block* %171, null, !dbg !874
  %175 = load %struct.block**, %struct.block*** @seglists, align 8, !dbg !876
  %176 = getelementptr inbounds %struct.block*, %struct.block** %175, i64 %169, !dbg !876
  %177 = getelementptr inbounds %struct.block, %struct.block* %171, i64 0, i32 1, i32 0, i32 0, !dbg !876
  %178 = select i1 %174, %struct.block** %176, %struct.block** %177, !dbg !876
  store %struct.block* %173, %struct.block** %178, align 8, !dbg !877, !tbaa !320
  %179 = icmp eq %struct.block* %173, null, !dbg !878
  br i1 %179, label %182, label %180, !dbg !880

180:                                              ; preds = %168
  %181 = getelementptr inbounds %struct.block, %struct.block* %173, i64 0, i32 1, i32 0, i32 1, !dbg !881
  store %struct.block* %171, %struct.block** %181, align 8, !dbg !883, !tbaa !320
  br label %182, !dbg !884

182:                                              ; preds = %150, %160, %164, %168, %180
  %183 = load i64, i64* %129, align 8, !dbg !885, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !886
  call void @llvm.dbg.value(metadata i64 %183, metadata !125, metadata !DIExpression()), !dbg !888
  %184 = and i64 %183, -16, !dbg !890
  call void @llvm.dbg.value(metadata i64 %184, metadata !554, metadata !DIExpression()), !dbg !555
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !731, metadata !DIExpression()), !dbg !891
  call void @llvm.dbg.value(metadata i64 %183, metadata !736, metadata !DIExpression()), !dbg !893
  %185 = and i64 %183, 4, !dbg !895
  call void @llvm.dbg.value(metadata %struct.block* %128, metadata !496, metadata !DIExpression()), !dbg !896
  call void @llvm.dbg.value(metadata i64 %184, metadata !501, metadata !DIExpression()), !dbg !896
  call void @llvm.dbg.value(metadata i1 true, metadata !502, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !896
  call void @llvm.dbg.value(metadata i1 undef, metadata !503, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !896
  call void @llvm.dbg.value(metadata i1 undef, metadata !504, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !896
  call void @llvm.dbg.value(metadata i64 %184, metadata !454, metadata !DIExpression()), !dbg !898
  call void @llvm.dbg.value(metadata i1 true, metadata !459, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !898
  call void @llvm.dbg.value(metadata i1 undef, metadata !460, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !898
  call void @llvm.dbg.value(metadata i1 undef, metadata !461, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !898
  call void @llvm.dbg.value(metadata i64 %184, metadata !462, metadata !DIExpression(DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)), !dbg !898
  %186 = or i64 %131, %184, !dbg !900
  call void @llvm.dbg.value(metadata i64 %186, metadata !462, metadata !DIExpression(DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)), !dbg !898
  %187 = or i64 %186, %185, !dbg !901
  %188 = or i64 %187, 1, !dbg !901
  call void @llvm.dbg.value(metadata !DIArgList(i64 %185, i64 %186), metadata !462, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_constu, 1, DW_OP_or, DW_OP_or, DW_OP_stack_value)), !dbg !898
  store i64 %188, i64* %129, align 8, !dbg !902, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* %128, metadata !181, metadata !DIExpression()), !dbg !903
  %189 = bitcast %struct.block* %128 to i8*, !dbg !905
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !906
  call void @llvm.dbg.value(metadata !DIArgList(i64 %185, i64 %186), metadata !125, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_constu, 1, DW_OP_or, DW_OP_or, DW_OP_stack_value)), !dbg !908
  %190 = getelementptr inbounds i8, i8* %189, i64 %184, !dbg !910
  call void @llvm.dbg.value(metadata i8* %190, metadata !508, metadata !DIExpression()), !dbg !896
  %191 = bitcast i8* %190 to i64*, !dbg !911
  %192 = load i64, i64* %191, align 8, !dbg !913, !tbaa !116
  %193 = or i64 %192, 2, !dbg !913
  store i64 %193, i64* %191, align 8, !dbg !913, !tbaa !116
  %194 = load i64, i64* %129, align 8, !dbg !914, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !251, metadata !DIExpression()), !dbg !915
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !917
  call void @llvm.dbg.value(metadata i64 %194, metadata !125, metadata !DIExpression()), !dbg !919
  %195 = and i64 %194, -16, !dbg !921
  %196 = icmp eq i64 %195, 16, !dbg !922
  %197 = and i64 %193, -5, !dbg !923
  %198 = select i1 %196, i64 4, i64 0, !dbg !923
  %199 = or i64 %198, %197, !dbg !923
  store i64 %199, i64* %191, align 8, !dbg !924, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* %128, metadata !925, metadata !DIExpression()), !dbg !936
  call void @llvm.dbg.value(metadata i64 undef, metadata !930, metadata !DIExpression()), !dbg !936
  %200 = load i64, i64* %129, align 8, !dbg !938, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !939
  call void @llvm.dbg.value(metadata i64 %200, metadata !125, metadata !DIExpression()), !dbg !941
  %201 = and i64 %200, -16, !dbg !943
  call void @llvm.dbg.value(metadata i64 %201, metadata !931, metadata !DIExpression()), !dbg !936
  %202 = sub i64 %201, %48, !dbg !944
  call void @llvm.dbg.value(metadata i64 %202, metadata !932, metadata !DIExpression()), !dbg !936
  %203 = icmp ugt i64 %202, 31, !dbg !945
  %204 = icmp eq i64 %202, 16
  %205 = or i1 %203, %204, !dbg !946
  br i1 %205, label %206, label %294, !dbg !946

206:                                              ; preds = %182
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !720, metadata !DIExpression()), !dbg !947
  call void @llvm.dbg.value(metadata i64 %200, metadata !725, metadata !DIExpression()), !dbg !949
  %207 = and i64 %200, 2, !dbg !951
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !731, metadata !DIExpression()), !dbg !952
  call void @llvm.dbg.value(metadata i64 %200, metadata !736, metadata !DIExpression()), !dbg !954
  %208 = and i64 %200, 4, !dbg !956
  call void @llvm.dbg.value(metadata %struct.block* %128, metadata !496, metadata !DIExpression()), !dbg !957
  call void @llvm.dbg.value(metadata i64 undef, metadata !501, metadata !DIExpression()), !dbg !957
  call void @llvm.dbg.value(metadata i1 true, metadata !502, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !957
  call void @llvm.dbg.value(metadata i1 undef, metadata !503, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !957
  call void @llvm.dbg.value(metadata i1 undef, metadata !504, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !957
  call void @llvm.dbg.value(metadata i64 undef, metadata !454, metadata !DIExpression()), !dbg !959
  call void @llvm.dbg.value(metadata i1 true, metadata !459, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !959
  call void @llvm.dbg.value(metadata i1 undef, metadata !460, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !959
  call void @llvm.dbg.value(metadata i1 undef, metadata !461, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !959
  call void @llvm.dbg.value(metadata !DIArgList(i64 %207, i64 undef), metadata !462, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_or, DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)), !dbg !959
  %209 = or i64 %48, %207, !dbg !961
  %210 = or i64 %209, %208, !dbg !961
  %211 = or i64 %210, 1, !dbg !961
  call void @llvm.dbg.value(metadata !DIArgList(i64 %207, i64 undef, i64 undef), metadata !462, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_or, DW_OP_LLVM_arg, 1, DW_OP_or, DW_OP_stack_value)), !dbg !959
  store i64 %211, i64* %129, align 8, !dbg !962, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* %128, metadata !181, metadata !DIExpression()), !dbg !963
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !965
  call void @llvm.dbg.value(metadata !DIArgList(i64 %207, i64 undef, i64 undef), metadata !125, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_or, DW_OP_LLVM_arg, 1, DW_OP_or, DW_OP_stack_value)), !dbg !967
  %212 = and i64 %48, -16, !dbg !969
  %213 = getelementptr inbounds i8, i8* %189, i64 %212, !dbg !970
  call void @llvm.dbg.value(metadata i8* %213, metadata !508, metadata !DIExpression()), !dbg !957
  %214 = bitcast i8* %213 to i64*, !dbg !971
  %215 = load i64, i64* %214, align 8, !dbg !972, !tbaa !116
  %216 = or i64 %215, 2, !dbg !972
  store i64 %216, i64* %214, align 8, !dbg !972, !tbaa !116
  %217 = load i64, i64* %129, align 8, !dbg !973, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !251, metadata !DIExpression()), !dbg !974
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !976
  call void @llvm.dbg.value(metadata i64 %217, metadata !125, metadata !DIExpression()), !dbg !978
  %218 = and i64 %217, -16, !dbg !980
  %219 = icmp eq i64 %218, 16, !dbg !981
  %220 = and i64 %216, -5, !dbg !982
  %221 = select i1 %219, i64 4, i64 0, !dbg !982
  %222 = or i64 %221, %220, !dbg !982
  store i64 %222, i64* %214, align 8, !dbg !983, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* %128, metadata !181, metadata !DIExpression()), !dbg !984
  %223 = load i64, i64* %129, align 8, !dbg !986, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !987
  call void @llvm.dbg.value(metadata i64 %223, metadata !125, metadata !DIExpression()), !dbg !989
  %224 = and i64 %223, -16, !dbg !991
  %225 = getelementptr inbounds i8, i8* %189, i64 %224, !dbg !992
  call void @llvm.dbg.value(metadata i8* %225, metadata !933, metadata !DIExpression()), !dbg !993
  %226 = icmp eq i64 %224, 16, !dbg !994
  call void @llvm.dbg.value(metadata i8* %225, metadata !496, metadata !DIExpression()), !dbg !996
  call void @llvm.dbg.value(metadata i8* %225, metadata !496, metadata !DIExpression()), !dbg !999
  br i1 %204, label %227, label %235, !dbg !1002

227:                                              ; preds = %206
  call void @llvm.dbg.value(metadata i8* %225, metadata !933, metadata !DIExpression()), !dbg !993
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !251, metadata !DIExpression()), !dbg !1003
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !1005
  call void @llvm.dbg.value(metadata i64 %223, metadata !125, metadata !DIExpression()), !dbg !1007
  call void @llvm.dbg.value(metadata i64 16, metadata !501, metadata !DIExpression()), !dbg !996
  call void @llvm.dbg.value(metadata i1 false, metadata !502, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !996
  call void @llvm.dbg.value(metadata i1 true, metadata !503, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !996
  call void @llvm.dbg.value(metadata i1 %226, metadata !504, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !996
  call void @llvm.dbg.value(metadata i64 16, metadata !454, metadata !DIExpression()), !dbg !1009
  call void @llvm.dbg.value(metadata i1 false, metadata !459, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1009
  call void @llvm.dbg.value(metadata i1 true, metadata !460, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1009
  call void @llvm.dbg.value(metadata i1 %226, metadata !461, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1009
  call void @llvm.dbg.value(metadata i64 18, metadata !462, metadata !DIExpression()), !dbg !1009
  %228 = select i1 %226, i64 22, i64 18, !dbg !1011
  call void @llvm.dbg.value(metadata i64 %228, metadata !462, metadata !DIExpression()), !dbg !1009
  %229 = bitcast i8* %225 to i64*, !dbg !1012
  store i64 %228, i64* %229, align 8, !dbg !1013, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !251, metadata !DIExpression()), !dbg !1014
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !1016
  call void @llvm.dbg.value(metadata i64 %228, metadata !125, metadata !DIExpression()), !dbg !1018
  call void @llvm.dbg.value(metadata i8* %225, metadata !181, metadata !DIExpression()), !dbg !1020
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !1022
  call void @llvm.dbg.value(metadata i64 %228, metadata !125, metadata !DIExpression()), !dbg !1024
  %230 = getelementptr inbounds i8, i8* %225, i64 16, !dbg !1026
  %231 = bitcast i8* %230 to i64*, !dbg !1027
  %232 = load i64, i64* %231, align 8, !dbg !1028, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !251, metadata !DIExpression()), !dbg !1029
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !1031
  call void @llvm.dbg.value(metadata i64 %228, metadata !125, metadata !DIExpression()), !dbg !1033
  %233 = and i64 %232, -7, !dbg !1035
  %234 = or i64 %233, 4, !dbg !1035
  store i64 %234, i64* %231, align 8, !dbg !1036, !tbaa !116
  br label %261, !dbg !1037

235:                                              ; preds = %206
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !251, metadata !DIExpression()), !dbg !1038
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !1040
  call void @llvm.dbg.value(metadata i64 %223, metadata !125, metadata !DIExpression()), !dbg !1042
  call void @llvm.dbg.value(metadata i64 %202, metadata !501, metadata !DIExpression()), !dbg !999
  call void @llvm.dbg.value(metadata i1 false, metadata !502, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !999
  call void @llvm.dbg.value(metadata i1 true, metadata !503, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !999
  call void @llvm.dbg.value(metadata i1 %226, metadata !504, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !999
  call void @llvm.dbg.value(metadata i64 %202, metadata !454, metadata !DIExpression()), !dbg !1044
  call void @llvm.dbg.value(metadata i1 false, metadata !459, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1044
  call void @llvm.dbg.value(metadata i1 true, metadata !460, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1044
  call void @llvm.dbg.value(metadata i1 %226, metadata !461, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1044
  call void @llvm.dbg.value(metadata i64 %202, metadata !462, metadata !DIExpression(DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)), !dbg !1044
  %236 = select i1 %226, i64 6, i64 2, !dbg !1046
  %237 = or i64 %236, %202, !dbg !1046
  call void @llvm.dbg.value(metadata !DIArgList(i64 %202, i64 %236), metadata !462, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_or, DW_OP_stack_value)), !dbg !1044
  %238 = bitcast i8* %225 to i64*, !dbg !1047
  store i64 %237, i64* %238, align 8, !dbg !1048, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !251, metadata !DIExpression()), !dbg !1049
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !1051
  call void @llvm.dbg.value(metadata !DIArgList(i64 %202, i64 %236), metadata !125, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_or, DW_OP_stack_value)), !dbg !1053
  %239 = and i64 %202, -16, !dbg !1055
  %240 = icmp eq i64 %239, 16, !dbg !1056
  br i1 %240, label %248, label %241, !dbg !1057

241:                                              ; preds = %235
  call void @llvm.dbg.value(metadata i8* %225, metadata !223, metadata !DIExpression()), !dbg !1058
  %242 = getelementptr inbounds i8, i8* %225, i64 8, !dbg !1060
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !1061
  call void @llvm.dbg.value(metadata !DIArgList(i64 %202, i64 %236), metadata !125, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_or, DW_OP_stack_value)), !dbg !1063
  %243 = getelementptr inbounds i8, i8* %242, i64 %239, !dbg !1065
  %244 = getelementptr inbounds i8, i8* %243, i64 -16, !dbg !1066
  %245 = bitcast i8* %244 to i64*, !dbg !1067
  call void @llvm.dbg.value(metadata i64* %245, metadata !505, metadata !DIExpression()), !dbg !1068
  call void @llvm.dbg.value(metadata i64 %202, metadata !454, metadata !DIExpression()), !dbg !1069
  call void @llvm.dbg.value(metadata i1 false, metadata !459, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1069
  call void @llvm.dbg.value(metadata i1 true, metadata !460, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1069
  call void @llvm.dbg.value(metadata i1 %226, metadata !461, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1069
  call void @llvm.dbg.value(metadata !DIArgList(i64 %202, i64 %236), metadata !462, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_or, DW_OP_stack_value)), !dbg !1069
  store i64 %237, i64* %245, align 8, !dbg !1071, !tbaa !94
  %246 = load i64, i64* %238, align 8, !dbg !1072, !tbaa !116
  %247 = and i64 %246, -16, !dbg !1074
  br label %248, !dbg !1077

248:                                              ; preds = %241, %235
  %249 = phi i64 [ %247, %241 ], [ 16, %235 ], !dbg !1074
  call void @llvm.dbg.value(metadata i8* %225, metadata !181, metadata !DIExpression()), !dbg !1078
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !1079
  call void @llvm.dbg.value(metadata !DIArgList(i64 %202, i64 %236), metadata !125, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_or, DW_OP_stack_value)), !dbg !1080
  %250 = getelementptr inbounds i8, i8* %225, i64 %249, !dbg !1081
  %251 = bitcast i8* %250 to i64*, !dbg !1082
  %252 = load i64, i64* %251, align 8, !dbg !1083, !tbaa !116
  %253 = and i64 %252, -3, !dbg !1083
  store i64 %253, i64* %251, align 8, !dbg !1083, !tbaa !116
  %254 = load i64, i64* %238, align 8, !dbg !1084, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !251, metadata !DIExpression()), !dbg !1085
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !1087
  call void @llvm.dbg.value(metadata i64 %254, metadata !125, metadata !DIExpression()), !dbg !1089
  %255 = and i64 %254, -16, !dbg !1091
  %256 = icmp eq i64 %255, 16, !dbg !1092
  %257 = and i64 %252, -7, !dbg !1093
  %258 = select i1 %256, i64 4, i64 0, !dbg !1093
  %259 = or i64 %258, %257, !dbg !1093
  store i64 %259, i64* %251, align 8, !dbg !1094, !tbaa !116
  %260 = load i64, i64* %238, align 8, !dbg !1095, !tbaa !116
  br label %261

261:                                              ; preds = %248, %227
  %262 = phi i64 [ %260, %248 ], [ %228, %227 ], !dbg !1095
  call void @llvm.dbg.value(metadata i8* %225, metadata !1098, metadata !DIExpression()), !dbg !1101
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !1102
  call void @llvm.dbg.value(metadata i64 %262, metadata !125, metadata !DIExpression()), !dbg !1104
  %263 = and i64 %262, -16, !dbg !1106
  call void @llvm.dbg.value(metadata i64 %263, metadata !334, metadata !DIExpression()), !dbg !1107
  switch i64 %263, label %264 [
    i64 16, label %272
    i64 0, label %277
  ], !dbg !1109

264:                                              ; preds = %261, %264
  %265 = phi i64 [ %267, %264 ], [ 1, %261 ]
  %266 = phi i64 [ %268, %264 ], [ %263, %261 ]
  call void @llvm.dbg.value(metadata i64 %265, metadata !339, metadata !DIExpression()), !dbg !1107
  call void @llvm.dbg.value(metadata i64 %266, metadata !334, metadata !DIExpression()), !dbg !1107
  %267 = add nuw nsw i64 %265, 1, !dbg !1110
  call void @llvm.dbg.value(metadata i64 %267, metadata !339, metadata !DIExpression()), !dbg !1107
  %268 = lshr i64 %266, 1, !dbg !1111
  call void @llvm.dbg.value(metadata i64 %268, metadata !334, metadata !DIExpression()), !dbg !1107
  %269 = icmp ugt i64 %266, 3, !dbg !1112
  %270 = icmp ult i64 %265, 38, !dbg !1113
  %271 = select i1 %269, i1 %270, i1 false, !dbg !1113
  br i1 %271, label %264, label %277, !dbg !1114, !llvm.loop !1115

272:                                              ; preds = %261
  %273 = load %struct.block**, %struct.block*** @seglists, align 8, !dbg !1117, !tbaa !112
  %274 = load %struct.block*, %struct.block** %273, align 8, !dbg !1117, !tbaa !112
  %275 = getelementptr inbounds i8, i8* %225, i64 8, !dbg !1120
  %276 = bitcast i8* %275 to %struct.block**, !dbg !1120
  store %struct.block* %274, %struct.block** %276, align 8, !dbg !1121, !tbaa !320
  br label %291, !dbg !1122

277:                                              ; preds = %264, %261
  %278 = phi i64 [ 1, %261 ], [ %267, %264 ]
  %279 = load %struct.block**, %struct.block*** @seglists, align 8, !dbg !1123, !tbaa !112
  %280 = getelementptr inbounds %struct.block*, %struct.block** %279, i64 %278, !dbg !1123
  %281 = load %struct.block*, %struct.block** %280, align 8, !dbg !1123, !tbaa !112
  %282 = getelementptr inbounds i8, i8* %225, i64 8, !dbg !1124
  %283 = bitcast i8* %282 to %struct.block**, !dbg !1124
  store %struct.block* %281, %struct.block** %283, align 8, !dbg !1125, !tbaa !320
  %284 = getelementptr inbounds i8, i8* %225, i64 16, !dbg !1126
  %285 = bitcast i8* %284 to %struct.block**, !dbg !1126
  store %struct.block* null, %struct.block** %285, align 8, !dbg !1127, !tbaa !320
  %286 = load %struct.block*, %struct.block** %280, align 8, !dbg !1128, !tbaa !112
  %287 = icmp eq %struct.block* %286, null, !dbg !1130
  br i1 %287, label %291, label %288, !dbg !1131

288:                                              ; preds = %277
  %289 = getelementptr inbounds %struct.block, %struct.block* %286, i64 0, i32 1, i32 0, i32 1, !dbg !1132
  %290 = bitcast %struct.block** %289 to i8**, !dbg !1134
  store i8* %225, i8** %290, align 8, !dbg !1134, !tbaa !320
  br label %291, !dbg !1135

291:                                              ; preds = %288, %277, %272
  %292 = phi %struct.block** [ %273, %272 ], [ %280, %288 ], [ %280, %277 ]
  %293 = bitcast %struct.block** %292 to i8**, !dbg !1101
  store i8* %225, i8** %293, align 8, !dbg !1101, !tbaa !112
  br label %294, !dbg !1136

294:                                              ; preds = %182, %291
  call void @llvm.dbg.value(metadata %struct.block* %128, metadata !144, metadata !DIExpression()), !dbg !1137
  %295 = getelementptr inbounds %struct.block, %struct.block* %128, i64 0, i32 1, !dbg !1139
  %296 = bitcast %union.anon* %295 to i8*, !dbg !1140
  call void @llvm.dbg.value(metadata i8* %296, metadata !552, metadata !DIExpression()), !dbg !555
  br label %297

297:                                              ; preds = %83, %10, %7, %4, %106, %30, %15, %294
  %298 = phi i8* [ %296, %294 ], [ null, %15 ], [ null, %30 ], [ null, %106 ], [ null, %4 ], [ null, %7 ], [ null, %10 ], [ null, %83 ], !dbg !555
  ret i8* %298, !dbg !1141
}

; Function Attrs: nofree norecurse nosync nounwind uwtable
define dso_local void @mm_free(i8* noundef %0) local_unnamed_addr #3 !dbg !1142 {
  call void @llvm.dbg.value(metadata i8* %0, metadata !1146, metadata !DIExpression()), !dbg !1149
  %2 = icmp eq i8* %0, null, !dbg !1150
  br i1 %2, label %30, label %3, !dbg !1152

3:                                                ; preds = %1
  call void @llvm.dbg.value(metadata i8* %0, metadata !486, metadata !DIExpression()), !dbg !1153
  %4 = getelementptr inbounds i8, i8* %0, i64 -8, !dbg !1155
  %5 = bitcast i8* %4 to %struct.block*, !dbg !1156
  call void @llvm.dbg.value(metadata %struct.block* %5, metadata !1147, metadata !DIExpression()), !dbg !1149
  %6 = bitcast i8* %4 to i64*, !dbg !1157
  %7 = load i64, i64* %6, align 8, !dbg !1157, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !1158
  call void @llvm.dbg.value(metadata i64 %7, metadata !125, metadata !DIExpression()), !dbg !1160
  call void @llvm.dbg.value(metadata i64 %7, metadata !1148, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)), !dbg !1149
  call void @llvm.dbg.value(metadata %struct.block* %5, metadata !496, metadata !DIExpression()), !dbg !1162
  call void @llvm.dbg.value(metadata i64 %7, metadata !501, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)), !dbg !1162
  call void @llvm.dbg.value(metadata i1 false, metadata !502, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1162
  call void @llvm.dbg.value(metadata i1 undef, metadata !503, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1162
  call void @llvm.dbg.value(metadata i1 undef, metadata !504, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1162
  call void @llvm.dbg.value(metadata i64 %7, metadata !454, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)), !dbg !1164
  call void @llvm.dbg.value(metadata i1 false, metadata !459, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1164
  call void @llvm.dbg.value(metadata i1 undef, metadata !460, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1164
  call void @llvm.dbg.value(metadata i1 undef, metadata !461, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1164
  call void @llvm.dbg.value(metadata i64 %7, metadata !462, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)), !dbg !1164
  call void @llvm.dbg.value(metadata i64 %7, metadata !462, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)), !dbg !1164
  call void @llvm.dbg.value(metadata i64 %7, metadata !462, metadata !DIExpression(DW_OP_constu, 18446744073709551602, DW_OP_and, DW_OP_stack_value)), !dbg !1164
  %8 = and i64 %7, -10, !dbg !1166
  call void @llvm.dbg.value(metadata i64 %8, metadata !462, metadata !DIExpression()), !dbg !1164
  store i64 %8, i64* %6, align 8, !dbg !1167, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !251, metadata !DIExpression()), !dbg !1168
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !1170
  call void @llvm.dbg.value(metadata i64 %8, metadata !125, metadata !DIExpression()), !dbg !1172
  %9 = and i64 %7, -16, !dbg !1174
  %10 = icmp eq i64 %9, 16, !dbg !1175
  br i1 %10, label %17, label %11, !dbg !1176

11:                                               ; preds = %3
  call void @llvm.dbg.value(metadata %struct.block* %5, metadata !223, metadata !DIExpression()), !dbg !1177
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !1179
  call void @llvm.dbg.value(metadata i64 %8, metadata !125, metadata !DIExpression()), !dbg !1181
  %12 = getelementptr inbounds i8, i8* %0, i64 %9, !dbg !1183
  %13 = getelementptr inbounds i8, i8* %12, i64 -16, !dbg !1184
  %14 = bitcast i8* %13 to i64*, !dbg !1185
  call void @llvm.dbg.value(metadata i64* %14, metadata !505, metadata !DIExpression()), !dbg !1186
  call void @llvm.dbg.value(metadata i64 %7, metadata !454, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)), !dbg !1187
  call void @llvm.dbg.value(metadata i1 false, metadata !459, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1187
  call void @llvm.dbg.value(metadata i1 undef, metadata !460, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1187
  call void @llvm.dbg.value(metadata i1 undef, metadata !461, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1187
  call void @llvm.dbg.value(metadata i64 %7, metadata !462, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)), !dbg !1187
  call void @llvm.dbg.value(metadata i64 %7, metadata !462, metadata !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_and, DW_OP_stack_value)), !dbg !1187
  call void @llvm.dbg.value(metadata i64 %7, metadata !462, metadata !DIExpression(DW_OP_constu, 18446744073709551602, DW_OP_and, DW_OP_stack_value)), !dbg !1187
  call void @llvm.dbg.value(metadata i64 %8, metadata !462, metadata !DIExpression()), !dbg !1187
  store i64 %8, i64* %14, align 8, !dbg !1189, !tbaa !94
  %15 = load i64, i64* %6, align 8, !dbg !1190, !tbaa !116
  %16 = and i64 %15, -16, !dbg !1192
  br label %17, !dbg !1195

17:                                               ; preds = %3, %11
  %18 = phi i64 [ %16, %11 ], [ 16, %3 ], !dbg !1192
  call void @llvm.dbg.value(metadata %struct.block* %5, metadata !181, metadata !DIExpression()), !dbg !1196
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !1197
  call void @llvm.dbg.value(metadata i64 %8, metadata !125, metadata !DIExpression()), !dbg !1198
  %19 = getelementptr inbounds i8, i8* %4, i64 %18, !dbg !1199
  %20 = bitcast i8* %19 to i64*, !dbg !1200
  %21 = load i64, i64* %20, align 8, !dbg !1201, !tbaa !116
  %22 = and i64 %21, -3, !dbg !1201
  store i64 %22, i64* %20, align 8, !dbg !1201, !tbaa !116
  %23 = load i64, i64* %6, align 8, !dbg !1202, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !251, metadata !DIExpression()), !dbg !1203
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !1205
  call void @llvm.dbg.value(metadata i64 %23, metadata !125, metadata !DIExpression()), !dbg !1207
  %24 = and i64 %23, -16, !dbg !1209
  %25 = icmp eq i64 %24, 16, !dbg !1210
  %26 = and i64 %21, -7, !dbg !1211
  %27 = select i1 %25, i64 4, i64 0, !dbg !1211
  %28 = or i64 %27, %26, !dbg !1211
  store i64 %28, i64* %20, align 8, !dbg !1212, !tbaa !116
  %29 = tail call fastcc %struct.block* @coalesce_block(%struct.block* noundef nonnull %5), !dbg !1213
  br label %30

30:                                               ; preds = %1, %17
  ret void, !dbg !1214
}

; Function Attrs: nofree norecurse nosync nounwind uwtable
define internal fastcc %struct.block* @coalesce_block(%struct.block* noundef %0) unnamed_addr #3 !dbg !1215 {
  call void @llvm.dbg.value(metadata %struct.block* %0, metadata !1217, metadata !DIExpression()), !dbg !1223
  call void @llvm.dbg.value(metadata %struct.block* null, metadata !1218, metadata !DIExpression()), !dbg !1223
  call void @llvm.dbg.value(metadata %struct.block* %0, metadata !181, metadata !DIExpression()), !dbg !1224
  %2 = bitcast %struct.block* %0 to i8*, !dbg !1226
  %3 = getelementptr %struct.block, %struct.block* %0, i64 0, i32 0, !dbg !1227
  %4 = load i64, i64* %3, align 8, !dbg !1227, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !1228
  call void @llvm.dbg.value(metadata i64 %4, metadata !125, metadata !DIExpression()), !dbg !1230
  %5 = and i64 %4, -16, !dbg !1232
  %6 = getelementptr inbounds i8, i8* %2, i64 %5, !dbg !1233
  %7 = bitcast i8* %6 to %struct.block*, !dbg !1234
  call void @llvm.dbg.value(metadata %struct.block* %7, metadata !1219, metadata !DIExpression()), !dbg !1223
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !720, metadata !DIExpression()), !dbg !1235
  call void @llvm.dbg.value(metadata i64 %4, metadata !725, metadata !DIExpression()), !dbg !1237
  %8 = and i64 %4, 2, !dbg !1239
  %9 = icmp eq i64 %8, 0, !dbg !1240
  call void @llvm.dbg.value(metadata i1 %9, metadata !1220, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1223
  %10 = bitcast i8* %6 to i64*, !dbg !1241
  %11 = load i64, i64* %10, align 8, !dbg !1241, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !165, metadata !DIExpression()), !dbg !1242
  call void @llvm.dbg.value(metadata i64 %11, metadata !171, metadata !DIExpression()), !dbg !1244
  %12 = and i64 %11, 1, !dbg !1246
  %13 = icmp eq i64 %12, 0, !dbg !1247
  call void @llvm.dbg.value(metadata i1 %13, metadata !1221, metadata !DIExpression(DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1223
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !1248
  call void @llvm.dbg.value(metadata i64 %4, metadata !125, metadata !DIExpression()), !dbg !1250
  call void @llvm.dbg.value(metadata i64 %5, metadata !1222, metadata !DIExpression()), !dbg !1223
  br i1 %9, label %14, label %29, !dbg !1252

14:                                               ; preds = %1
  call void @llvm.dbg.value(metadata %struct.block* %0, metadata !1253, metadata !DIExpression()), !dbg !1257
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !731, metadata !DIExpression()), !dbg !1261
  call void @llvm.dbg.value(metadata i64 %4, metadata !736, metadata !DIExpression()), !dbg !1264
  %15 = and i64 %4, 4, !dbg !1266
  %16 = icmp eq i64 %15, 0, !dbg !1267
  br i1 %16, label %20, label %17, !dbg !1268

17:                                               ; preds = %14
  %18 = getelementptr inbounds %struct.block, %struct.block* %0, i64 -1, i32 1, !dbg !1269
  %19 = bitcast %union.anon* %18 to %struct.block*, !dbg !1271
  br label %56, !dbg !1272

20:                                               ; preds = %14
  call void @llvm.dbg.value(metadata %struct.block* %0, metadata !1273, metadata !DIExpression()), !dbg !1276
  %21 = getelementptr inbounds i64, i64* %3, i64 -1, !dbg !1278
  call void @llvm.dbg.value(metadata i64* %21, metadata !1256, metadata !DIExpression()), !dbg !1257
  %22 = load i64, i64* %21, align 8, !dbg !1279, !tbaa !94
  call void @llvm.dbg.value(metadata i64 %22, metadata !125, metadata !DIExpression()), !dbg !1281
  %23 = and i64 %22, -16, !dbg !1283
  %24 = icmp eq i64 %23, 0, !dbg !1284
  br i1 %24, label %56, label %25, !dbg !1285

25:                                               ; preds = %20
  call void @llvm.dbg.value(metadata i64* %21, metadata !1286, metadata !DIExpression()), !dbg !1292
  call void @llvm.dbg.value(metadata i64 %22, metadata !125, metadata !DIExpression()), !dbg !1294
  call void @llvm.dbg.value(metadata i64 %23, metadata !1291, metadata !DIExpression()), !dbg !1292
  %26 = sub i64 0, %23, !dbg !1296
  %27 = getelementptr inbounds i8, i8* %2, i64 %26, !dbg !1296
  %28 = bitcast i8* %27 to %struct.block*, !dbg !1297
  br label %56, !dbg !1298

29:                                               ; preds = %1
  call void @llvm.dbg.value(metadata i1 %13, metadata !1221, metadata !DIExpression(DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1223
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !1218, metadata !DIExpression()), !dbg !1223
  br i1 %13, label %326, label %30, !dbg !1299

30:                                               ; preds = %29
  call void @llvm.dbg.value(metadata %struct.block* %0, metadata !1098, metadata !DIExpression()), !dbg !1301
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !1304
  call void @llvm.dbg.value(metadata i64 %4, metadata !125, metadata !DIExpression()), !dbg !1306
  call void @llvm.dbg.value(metadata i64 %5, metadata !334, metadata !DIExpression()), !dbg !1308
  switch i64 %5, label %31 [
    i64 16, label %39
    i64 0, label %43
  ], !dbg !1310

31:                                               ; preds = %30, %31
  %32 = phi i64 [ %34, %31 ], [ 1, %30 ]
  %33 = phi i64 [ %35, %31 ], [ %5, %30 ]
  call void @llvm.dbg.value(metadata i64 %32, metadata !339, metadata !DIExpression()), !dbg !1308
  call void @llvm.dbg.value(metadata i64 %33, metadata !334, metadata !DIExpression()), !dbg !1308
  %34 = add nuw nsw i64 %32, 1, !dbg !1311
  call void @llvm.dbg.value(metadata i64 %34, metadata !339, metadata !DIExpression()), !dbg !1308
  %35 = lshr i64 %33, 1, !dbg !1312
  call void @llvm.dbg.value(metadata i64 %35, metadata !334, metadata !DIExpression()), !dbg !1308
  %36 = icmp ugt i64 %33, 3, !dbg !1313
  %37 = icmp ult i64 %32, 38, !dbg !1314
  %38 = select i1 %36, i1 %37, i1 false, !dbg !1314
  br i1 %38, label %31, label %43, !dbg !1315, !llvm.loop !1316

39:                                               ; preds = %30
  %40 = load %struct.block**, %struct.block*** @seglists, align 8, !dbg !1318, !tbaa !112
  %41 = load %struct.block*, %struct.block** %40, align 8, !dbg !1318, !tbaa !112
  %42 = getelementptr inbounds %struct.block, %struct.block* %0, i64 0, i32 1, i32 0, i32 0, !dbg !1319
  store %struct.block* %41, %struct.block** %42, align 8, !dbg !1320, !tbaa !320
  br label %54, !dbg !1321

43:                                               ; preds = %31, %30
  %44 = phi i64 [ 1, %30 ], [ %34, %31 ]
  %45 = load %struct.block**, %struct.block*** @seglists, align 8, !dbg !1322, !tbaa !112
  %46 = getelementptr inbounds %struct.block*, %struct.block** %45, i64 %44, !dbg !1322
  %47 = load %struct.block*, %struct.block** %46, align 8, !dbg !1322, !tbaa !112
  %48 = getelementptr inbounds %struct.block, %struct.block* %0, i64 0, i32 1, i32 0, i32 0, !dbg !1323
  store %struct.block* %47, %struct.block** %48, align 8, !dbg !1324, !tbaa !320
  %49 = getelementptr inbounds %struct.block, %struct.block* %0, i64 0, i32 1, i32 0, i32 1, !dbg !1325
  store %struct.block* null, %struct.block** %49, align 8, !dbg !1326, !tbaa !320
  %50 = load %struct.block*, %struct.block** %46, align 8, !dbg !1327, !tbaa !112
  %51 = icmp eq %struct.block* %50, null, !dbg !1328
  br i1 %51, label %54, label %52, !dbg !1329

52:                                               ; preds = %43
  %53 = getelementptr inbounds %struct.block, %struct.block* %50, i64 0, i32 1, i32 0, i32 1, !dbg !1330
  store %struct.block* %0, %struct.block** %53, align 8, !dbg !1331, !tbaa !320
  br label %54, !dbg !1332

54:                                               ; preds = %39, %43, %52
  %55 = phi %struct.block** [ %40, %39 ], [ %46, %52 ], [ %46, %43 ]
  store %struct.block* %0, %struct.block** %55, align 8, !dbg !1301, !tbaa !112
  br label %433, !dbg !1333

56:                                               ; preds = %25, %20, %17
  %57 = phi %struct.block* [ null, %20 ], [ %28, %25 ], [ %19, %17 ]
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !1218, metadata !DIExpression()), !dbg !1223
  %58 = getelementptr %struct.block, %struct.block* %57, i64 0, i32 0, !dbg !1223
  %59 = load i64, i64* %58, align 8, !dbg !1223, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !1334
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !1338
  call void @llvm.dbg.value(metadata i64 %59, metadata !125, metadata !DIExpression()), !dbg !1342
  call void @llvm.dbg.value(metadata i64 %59, metadata !125, metadata !DIExpression()), !dbg !1344
  %60 = and i64 %59, -16, !dbg !1223
  br i1 %13, label %61, label %221, !dbg !1346

61:                                               ; preds = %56
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !1347
  call void @llvm.dbg.value(metadata i64 %11, metadata !125, metadata !DIExpression()), !dbg !1349
  %62 = and i64 %11, -16, !dbg !1351
  %63 = add i64 %60, %5, !dbg !1352
  %64 = add i64 %63, %62, !dbg !1353
  call void @llvm.dbg.value(metadata i64 %64, metadata !1222, metadata !DIExpression()), !dbg !1223
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !822, metadata !DIExpression()), !dbg !1354
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !1356
  call void @llvm.dbg.value(metadata i64 %59, metadata !125, metadata !DIExpression()), !dbg !1358
  call void @llvm.dbg.value(metadata i64 %60, metadata !334, metadata !DIExpression()), !dbg !1360
  switch i64 %60, label %65 [
    i64 16, label %73
    i64 0, label %100
  ], !dbg !1362

65:                                               ; preds = %61, %65
  %66 = phi i64 [ %68, %65 ], [ 1, %61 ]
  %67 = phi i64 [ %69, %65 ], [ %60, %61 ]
  call void @llvm.dbg.value(metadata i64 %66, metadata !339, metadata !DIExpression()), !dbg !1360
  call void @llvm.dbg.value(metadata i64 %67, metadata !334, metadata !DIExpression()), !dbg !1360
  %68 = add nuw nsw i64 %66, 1, !dbg !1363
  call void @llvm.dbg.value(metadata i64 %68, metadata !339, metadata !DIExpression()), !dbg !1360
  %69 = lshr i64 %67, 1, !dbg !1364
  call void @llvm.dbg.value(metadata i64 %69, metadata !334, metadata !DIExpression()), !dbg !1360
  %70 = icmp ugt i64 %67, 3, !dbg !1365
  %71 = icmp ult i64 %66, 38, !dbg !1366
  %72 = select i1 %70, i1 %71, i1 false, !dbg !1366
  br i1 %72, label %65, label %100, !dbg !1367, !llvm.loop !1368

73:                                               ; preds = %61
  call void @llvm.dbg.value(metadata %struct.block* null, metadata !826, metadata !DIExpression()), !dbg !1370
  %74 = load %struct.block**, %struct.block*** @seglists, align 8, !dbg !1371, !tbaa !112
  %75 = load %struct.block*, %struct.block** %74, align 8, !dbg !1371, !tbaa !112
  call void @llvm.dbg.value(metadata %struct.block* %75, metadata !829, metadata !DIExpression()), !dbg !1370
  %76 = icmp ne %struct.block* %75, null, !dbg !1372
  %77 = icmp eq %struct.block* %75, %57
  %78 = and i1 %76, %77, !dbg !1373
  br i1 %78, label %82, label %79, !dbg !1373

79:                                               ; preds = %73
  call void @llvm.dbg.value(metadata %struct.block* null, metadata !826, metadata !DIExpression()), !dbg !1370
  call void @llvm.dbg.value(metadata %struct.block* %75, metadata !829, metadata !DIExpression()), !dbg !1370
  %80 = icmp ne %struct.block* %75, %57, !dbg !1374
  %81 = and i1 %76, %80, !dbg !1374
  br i1 %81, label %85, label %92, !dbg !1375

82:                                               ; preds = %73
  %83 = getelementptr inbounds %struct.block, %struct.block* %57, i64 0, i32 1, i32 0, i32 0, !dbg !1376
  %84 = load %struct.block*, %struct.block** %83, align 8, !dbg !1376, !tbaa !320
  store %struct.block* %84, %struct.block** %74, align 8, !dbg !1377, !tbaa !112
  br label %114, !dbg !1378

85:                                               ; preds = %79, %85
  %86 = phi %struct.block* [ %88, %85 ], [ %75, %79 ]
  call void @llvm.dbg.value(metadata %struct.block* %86, metadata !829, metadata !DIExpression()), !dbg !1370
  call void @llvm.dbg.value(metadata %struct.block* %86, metadata !826, metadata !DIExpression()), !dbg !1370
  %87 = getelementptr inbounds %struct.block, %struct.block* %86, i64 0, i32 1, i32 0, i32 0, !dbg !1379
  %88 = load %struct.block*, %struct.block** %87, align 8, !dbg !1379, !tbaa !320
  call void @llvm.dbg.value(metadata %struct.block* %88, metadata !829, metadata !DIExpression()), !dbg !1370
  %89 = icmp ne %struct.block* %88, null, !dbg !1380
  %90 = icmp ne %struct.block* %88, %57, !dbg !1374
  %91 = and i1 %89, %90, !dbg !1374
  br i1 %91, label %85, label %92, !dbg !1375, !llvm.loop !1381

92:                                               ; preds = %85, %79
  %93 = phi %struct.block* [ %75, %79 ], [ %88, %85 ], !dbg !1370
  %94 = phi %struct.block* [ null, %79 ], [ %86, %85 ], !dbg !1370
  %95 = icmp eq %struct.block* %93, null, !dbg !1383
  br i1 %95, label %114, label %96, !dbg !1384

96:                                               ; preds = %92
  %97 = getelementptr inbounds %struct.block, %struct.block* %93, i64 0, i32 1, i32 0, i32 0, !dbg !1385
  %98 = load %struct.block*, %struct.block** %97, align 8, !dbg !1385, !tbaa !320
  %99 = getelementptr inbounds %struct.block, %struct.block* %94, i64 0, i32 1, i32 0, i32 0, !dbg !1386
  store %struct.block* %98, %struct.block** %99, align 8, !dbg !1387, !tbaa !320
  br label %114, !dbg !1388

100:                                              ; preds = %65, %61
  %101 = phi i64 [ 1, %61 ], [ %68, %65 ]
  %102 = getelementptr inbounds %struct.block, %struct.block* %57, i64 0, i32 1, i32 0, i32 1, !dbg !1389
  %103 = load %struct.block*, %struct.block** %102, align 8, !dbg !1389, !tbaa !320
  call void @llvm.dbg.value(metadata %struct.block* %103, metadata !830, metadata !DIExpression()), !dbg !1354
  %104 = getelementptr inbounds %struct.block, %struct.block* %57, i64 0, i32 1, i32 0, i32 0, !dbg !1390
  %105 = load %struct.block*, %struct.block** %104, align 8, !dbg !1390, !tbaa !320
  call void @llvm.dbg.value(metadata %struct.block* %105, metadata !831, metadata !DIExpression()), !dbg !1354
  %106 = icmp eq %struct.block* %103, null, !dbg !1391
  %107 = load %struct.block**, %struct.block*** @seglists, align 8, !dbg !1392
  %108 = getelementptr inbounds %struct.block*, %struct.block** %107, i64 %101, !dbg !1392
  %109 = getelementptr inbounds %struct.block, %struct.block* %103, i64 0, i32 1, i32 0, i32 0, !dbg !1392
  %110 = select i1 %106, %struct.block** %108, %struct.block** %109, !dbg !1392
  store %struct.block* %105, %struct.block** %110, align 8, !dbg !1393, !tbaa !320
  %111 = icmp eq %struct.block* %105, null, !dbg !1394
  br i1 %111, label %114, label %112, !dbg !1395

112:                                              ; preds = %100
  %113 = getelementptr inbounds %struct.block, %struct.block* %105, i64 0, i32 1, i32 0, i32 1, !dbg !1396
  store %struct.block* %103, %struct.block** %113, align 8, !dbg !1397, !tbaa !320
  br label %114, !dbg !1398

114:                                              ; preds = %82, %92, %96, %100, %112
  %115 = phi %struct.block** [ %74, %82 ], [ %74, %92 ], [ %74, %96 ], [ %107, %100 ], [ %107, %112 ]
  call void @llvm.dbg.value(metadata %struct.block* %7, metadata !822, metadata !DIExpression()), !dbg !1399
  %116 = load i64, i64* %10, align 8, !dbg !1401, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !1402
  call void @llvm.dbg.value(metadata i64 %116, metadata !125, metadata !DIExpression()), !dbg !1404
  %117 = and i64 %116, -16, !dbg !1406
  call void @llvm.dbg.value(metadata i64 %117, metadata !334, metadata !DIExpression()), !dbg !1407
  switch i64 %117, label %118 [
    i64 16, label %126
    i64 0, label %153
  ], !dbg !1409

118:                                              ; preds = %114, %118
  %119 = phi i64 [ %121, %118 ], [ 1, %114 ]
  %120 = phi i64 [ %122, %118 ], [ %117, %114 ]
  call void @llvm.dbg.value(metadata i64 %119, metadata !339, metadata !DIExpression()), !dbg !1407
  call void @llvm.dbg.value(metadata i64 %120, metadata !334, metadata !DIExpression()), !dbg !1407
  %121 = add nuw nsw i64 %119, 1, !dbg !1410
  call void @llvm.dbg.value(metadata i64 %121, metadata !339, metadata !DIExpression()), !dbg !1407
  %122 = lshr i64 %120, 1, !dbg !1411
  call void @llvm.dbg.value(metadata i64 %122, metadata !334, metadata !DIExpression()), !dbg !1407
  %123 = icmp ugt i64 %120, 3, !dbg !1412
  %124 = icmp ult i64 %119, 38, !dbg !1413
  %125 = select i1 %123, i1 %124, i1 false, !dbg !1413
  br i1 %125, label %118, label %153, !dbg !1414, !llvm.loop !1415

126:                                              ; preds = %114
  call void @llvm.dbg.value(metadata %struct.block* null, metadata !826, metadata !DIExpression()), !dbg !1417
  %127 = load %struct.block*, %struct.block** %115, align 8, !dbg !1418, !tbaa !112
  call void @llvm.dbg.value(metadata %struct.block* %127, metadata !829, metadata !DIExpression()), !dbg !1417
  %128 = icmp ne %struct.block* %127, null, !dbg !1419
  %129 = icmp eq %struct.block* %127, %7
  %130 = and i1 %128, %129, !dbg !1420
  br i1 %130, label %134, label %131, !dbg !1420

131:                                              ; preds = %126
  call void @llvm.dbg.value(metadata %struct.block* null, metadata !826, metadata !DIExpression()), !dbg !1417
  call void @llvm.dbg.value(metadata %struct.block* %127, metadata !829, metadata !DIExpression()), !dbg !1417
  %132 = icmp ne %struct.block* %127, %7, !dbg !1421
  %133 = and i1 %128, %132, !dbg !1421
  br i1 %133, label %138, label %145, !dbg !1422

134:                                              ; preds = %126
  %135 = getelementptr inbounds i8, i8* %6, i64 8, !dbg !1423
  %136 = bitcast i8* %135 to %struct.block**, !dbg !1423
  %137 = load %struct.block*, %struct.block** %136, align 8, !dbg !1423, !tbaa !320
  store %struct.block* %137, %struct.block** %115, align 8, !dbg !1424, !tbaa !112
  br label %168, !dbg !1425

138:                                              ; preds = %131, %138
  %139 = phi %struct.block* [ %141, %138 ], [ %127, %131 ]
  call void @llvm.dbg.value(metadata %struct.block* %139, metadata !829, metadata !DIExpression()), !dbg !1417
  call void @llvm.dbg.value(metadata %struct.block* %139, metadata !826, metadata !DIExpression()), !dbg !1417
  %140 = getelementptr inbounds %struct.block, %struct.block* %139, i64 0, i32 1, i32 0, i32 0, !dbg !1426
  %141 = load %struct.block*, %struct.block** %140, align 8, !dbg !1426, !tbaa !320
  call void @llvm.dbg.value(metadata %struct.block* %141, metadata !829, metadata !DIExpression()), !dbg !1417
  %142 = icmp ne %struct.block* %141, null, !dbg !1427
  %143 = icmp ne %struct.block* %141, %7, !dbg !1421
  %144 = and i1 %142, %143, !dbg !1421
  br i1 %144, label %138, label %145, !dbg !1422, !llvm.loop !1428

145:                                              ; preds = %138, %131
  %146 = phi %struct.block* [ %127, %131 ], [ %141, %138 ], !dbg !1417
  %147 = phi %struct.block* [ null, %131 ], [ %139, %138 ], !dbg !1417
  %148 = icmp eq %struct.block* %146, null, !dbg !1430
  br i1 %148, label %168, label %149, !dbg !1431

149:                                              ; preds = %145
  %150 = getelementptr inbounds %struct.block, %struct.block* %146, i64 0, i32 1, i32 0, i32 0, !dbg !1432
  %151 = load %struct.block*, %struct.block** %150, align 8, !dbg !1432, !tbaa !320
  %152 = getelementptr inbounds %struct.block, %struct.block* %147, i64 0, i32 1, i32 0, i32 0, !dbg !1433
  store %struct.block* %151, %struct.block** %152, align 8, !dbg !1434, !tbaa !320
  br label %168, !dbg !1435

153:                                              ; preds = %118, %114
  %154 = phi i64 [ 1, %114 ], [ %121, %118 ]
  %155 = getelementptr inbounds i8, i8* %6, i64 16, !dbg !1436
  %156 = bitcast i8* %155 to %struct.block**, !dbg !1436
  %157 = load %struct.block*, %struct.block** %156, align 8, !dbg !1436, !tbaa !320
  call void @llvm.dbg.value(metadata %struct.block* %157, metadata !830, metadata !DIExpression()), !dbg !1399
  %158 = getelementptr inbounds i8, i8* %6, i64 8, !dbg !1437
  %159 = bitcast i8* %158 to %struct.block**, !dbg !1437
  %160 = load %struct.block*, %struct.block** %159, align 8, !dbg !1437, !tbaa !320
  call void @llvm.dbg.value(metadata %struct.block* %160, metadata !831, metadata !DIExpression()), !dbg !1399
  %161 = icmp eq %struct.block* %157, null, !dbg !1438
  %162 = getelementptr inbounds %struct.block*, %struct.block** %115, i64 %154, !dbg !1439
  %163 = getelementptr inbounds %struct.block, %struct.block* %157, i64 0, i32 1, i32 0, i32 0, !dbg !1439
  %164 = select i1 %161, %struct.block** %162, %struct.block** %163, !dbg !1439
  store %struct.block* %160, %struct.block** %164, align 8, !dbg !1440, !tbaa !320
  %165 = icmp eq %struct.block* %160, null, !dbg !1441
  br i1 %165, label %168, label %166, !dbg !1442

166:                                              ; preds = %153
  %167 = getelementptr inbounds %struct.block, %struct.block* %160, i64 0, i32 1, i32 0, i32 1, !dbg !1443
  store %struct.block* %157, %struct.block** %167, align 8, !dbg !1444, !tbaa !320
  br label %168, !dbg !1445

168:                                              ; preds = %134, %145, %149, %153, %166
  %169 = load i64, i64* %58, align 8, !dbg !1446, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !720, metadata !DIExpression()), !dbg !1447
  call void @llvm.dbg.value(metadata i64 %169, metadata !725, metadata !DIExpression()), !dbg !1449
  %170 = and i64 %169, 2, !dbg !1451
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !731, metadata !DIExpression()), !dbg !1452
  call void @llvm.dbg.value(metadata i64 %169, metadata !736, metadata !DIExpression()), !dbg !1454
  %171 = and i64 %169, 4, !dbg !1456
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !496, metadata !DIExpression()), !dbg !1457
  call void @llvm.dbg.value(metadata i64 %64, metadata !501, metadata !DIExpression()), !dbg !1457
  call void @llvm.dbg.value(metadata i1 false, metadata !502, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1457
  call void @llvm.dbg.value(metadata i1 undef, metadata !503, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1457
  call void @llvm.dbg.value(metadata i1 undef, metadata !504, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1457
  call void @llvm.dbg.value(metadata i64 %64, metadata !454, metadata !DIExpression()), !dbg !1459
  call void @llvm.dbg.value(metadata i1 false, metadata !459, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1459
  call void @llvm.dbg.value(metadata i1 undef, metadata !460, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1459
  call void @llvm.dbg.value(metadata i1 undef, metadata !461, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1459
  call void @llvm.dbg.value(metadata i64 %64, metadata !462, metadata !DIExpression()), !dbg !1459
  %172 = or i64 %170, %64, !dbg !1461
  call void @llvm.dbg.value(metadata !DIArgList(i64 %170, i64 %64), metadata !462, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_or, DW_OP_stack_value)), !dbg !1459
  %173 = or i64 %172, %171, !dbg !1462
  call void @llvm.dbg.value(metadata !DIArgList(i64 %171, i64 %170, i64 %64), metadata !462, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_or, DW_OP_or, DW_OP_stack_value)), !dbg !1459
  store i64 %173, i64* %58, align 8, !dbg !1463, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !251, metadata !DIExpression()), !dbg !1464
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !1466
  call void @llvm.dbg.value(metadata !DIArgList(i64 %171, i64 %170, i64 %64), metadata !125, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_or, DW_OP_or, DW_OP_stack_value)), !dbg !1468
  %174 = icmp eq i64 %64, 16, !dbg !1470
  br i1 %174, label %183, label %175, !dbg !1471

175:                                              ; preds = %168
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !223, metadata !DIExpression()), !dbg !1472
  %176 = getelementptr inbounds %struct.block, %struct.block* %57, i64 0, i32 1, !dbg !1474
  %177 = bitcast %union.anon* %176 to i8*, !dbg !1475
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !1476
  call void @llvm.dbg.value(metadata !DIArgList(i64 %171, i64 %170, i64 %64), metadata !125, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_or, DW_OP_or, DW_OP_stack_value)), !dbg !1478
  %178 = getelementptr inbounds i8, i8* %177, i64 %64, !dbg !1480
  %179 = getelementptr inbounds i8, i8* %178, i64 -16, !dbg !1481
  %180 = bitcast i8* %179 to i64*, !dbg !1482
  call void @llvm.dbg.value(metadata i64* %180, metadata !505, metadata !DIExpression()), !dbg !1483
  call void @llvm.dbg.value(metadata i64 %64, metadata !454, metadata !DIExpression()), !dbg !1484
  call void @llvm.dbg.value(metadata i1 false, metadata !459, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1484
  call void @llvm.dbg.value(metadata i1 undef, metadata !460, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1484
  call void @llvm.dbg.value(metadata i1 undef, metadata !461, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1484
  call void @llvm.dbg.value(metadata !DIArgList(i64 %171, i64 %170, i64 %64), metadata !462, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_or, DW_OP_or, DW_OP_stack_value)), !dbg !1484
  store i64 %173, i64* %180, align 8, !dbg !1486, !tbaa !94
  %181 = load i64, i64* %58, align 8, !dbg !1487, !tbaa !116
  %182 = and i64 %181, -16, !dbg !1489
  br label %183, !dbg !1492

183:                                              ; preds = %168, %175
  %184 = phi i64 [ %182, %175 ], [ 16, %168 ], !dbg !1489
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !181, metadata !DIExpression()), !dbg !1493
  %185 = bitcast %struct.block* %57 to i8*, !dbg !1494
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !1495
  call void @llvm.dbg.value(metadata !DIArgList(i64 %171, i64 %170, i64 %64), metadata !125, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_or, DW_OP_or, DW_OP_stack_value)), !dbg !1496
  %186 = getelementptr inbounds i8, i8* %185, i64 %184, !dbg !1497
  %187 = bitcast i8* %186 to i64*, !dbg !1498
  %188 = load i64, i64* %187, align 8, !dbg !1499, !tbaa !116
  %189 = and i64 %188, -3, !dbg !1499
  store i64 %189, i64* %187, align 8, !dbg !1499, !tbaa !116
  %190 = load i64, i64* %58, align 8, !dbg !1500, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !251, metadata !DIExpression()), !dbg !1501
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !1503
  call void @llvm.dbg.value(metadata i64 %190, metadata !125, metadata !DIExpression()), !dbg !1505
  %191 = and i64 %190, -16, !dbg !1507
  %192 = icmp eq i64 %191, 16, !dbg !1508
  %193 = and i64 %188, -7, !dbg !1509
  %194 = select i1 %192, i64 4, i64 0, !dbg !1509
  %195 = or i64 %194, %193, !dbg !1509
  store i64 %195, i64* %187, align 8, !dbg !1510, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !1098, metadata !DIExpression()), !dbg !1511
  %196 = load i64, i64* %58, align 8, !dbg !1513, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !1514
  call void @llvm.dbg.value(metadata i64 %196, metadata !125, metadata !DIExpression()), !dbg !1516
  %197 = and i64 %196, -16, !dbg !1518
  call void @llvm.dbg.value(metadata i64 %197, metadata !334, metadata !DIExpression()), !dbg !1519
  switch i64 %197, label %198 [
    i64 16, label %206
    i64 0, label %209
  ], !dbg !1521

198:                                              ; preds = %183, %198
  %199 = phi i64 [ %201, %198 ], [ 1, %183 ]
  %200 = phi i64 [ %202, %198 ], [ %197, %183 ]
  call void @llvm.dbg.value(metadata i64 %199, metadata !339, metadata !DIExpression()), !dbg !1519
  call void @llvm.dbg.value(metadata i64 %200, metadata !334, metadata !DIExpression()), !dbg !1519
  %201 = add nuw nsw i64 %199, 1, !dbg !1522
  call void @llvm.dbg.value(metadata i64 %201, metadata !339, metadata !DIExpression()), !dbg !1519
  %202 = lshr i64 %200, 1, !dbg !1523
  call void @llvm.dbg.value(metadata i64 %202, metadata !334, metadata !DIExpression()), !dbg !1519
  %203 = icmp ugt i64 %200, 3, !dbg !1524
  %204 = icmp ult i64 %199, 38, !dbg !1525
  %205 = select i1 %203, i1 %204, i1 false, !dbg !1525
  br i1 %205, label %198, label %209, !dbg !1526, !llvm.loop !1527

206:                                              ; preds = %183
  %207 = load %struct.block*, %struct.block** %115, align 8, !dbg !1529, !tbaa !112
  %208 = getelementptr inbounds %struct.block, %struct.block* %57, i64 0, i32 1, i32 0, i32 0, !dbg !1530
  store %struct.block* %207, %struct.block** %208, align 8, !dbg !1531, !tbaa !320
  br label %219, !dbg !1532

209:                                              ; preds = %198, %183
  %210 = phi i64 [ 1, %183 ], [ %201, %198 ]
  %211 = getelementptr inbounds %struct.block*, %struct.block** %115, i64 %210, !dbg !1533
  %212 = load %struct.block*, %struct.block** %211, align 8, !dbg !1533, !tbaa !112
  %213 = getelementptr inbounds %struct.block, %struct.block* %57, i64 0, i32 1, i32 0, i32 0, !dbg !1534
  store %struct.block* %212, %struct.block** %213, align 8, !dbg !1535, !tbaa !320
  %214 = getelementptr inbounds %struct.block, %struct.block* %57, i64 0, i32 1, i32 0, i32 1, !dbg !1536
  store %struct.block* null, %struct.block** %214, align 8, !dbg !1537, !tbaa !320
  %215 = load %struct.block*, %struct.block** %211, align 8, !dbg !1538, !tbaa !112
  %216 = icmp eq %struct.block* %215, null, !dbg !1539
  br i1 %216, label %219, label %217, !dbg !1540

217:                                              ; preds = %209
  %218 = getelementptr inbounds %struct.block, %struct.block* %215, i64 0, i32 1, i32 0, i32 1, !dbg !1541
  store %struct.block* %57, %struct.block** %218, align 8, !dbg !1542, !tbaa !320
  br label %219, !dbg !1543

219:                                              ; preds = %206, %209, %217
  %220 = phi %struct.block** [ %115, %206 ], [ %211, %217 ], [ %211, %209 ]
  store %struct.block* %57, %struct.block** %220, align 8, !dbg !1511, !tbaa !112
  br label %433, !dbg !1544

221:                                              ; preds = %56
  %222 = add i64 %60, %5, !dbg !1545
  call void @llvm.dbg.value(metadata i64 %222, metadata !1222, metadata !DIExpression()), !dbg !1223
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !822, metadata !DIExpression()), !dbg !1546
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !1548
  call void @llvm.dbg.value(metadata i64 %59, metadata !125, metadata !DIExpression()), !dbg !1550
  call void @llvm.dbg.value(metadata i64 %60, metadata !334, metadata !DIExpression()), !dbg !1552
  switch i64 %60, label %223 [
    i64 16, label %231
    i64 0, label %258
  ], !dbg !1554

223:                                              ; preds = %221, %223
  %224 = phi i64 [ %226, %223 ], [ 1, %221 ]
  %225 = phi i64 [ %227, %223 ], [ %60, %221 ]
  call void @llvm.dbg.value(metadata i64 %224, metadata !339, metadata !DIExpression()), !dbg !1552
  call void @llvm.dbg.value(metadata i64 %225, metadata !334, metadata !DIExpression()), !dbg !1552
  %226 = add nuw nsw i64 %224, 1, !dbg !1555
  call void @llvm.dbg.value(metadata i64 %226, metadata !339, metadata !DIExpression()), !dbg !1552
  %227 = lshr i64 %225, 1, !dbg !1556
  call void @llvm.dbg.value(metadata i64 %227, metadata !334, metadata !DIExpression()), !dbg !1552
  %228 = icmp ugt i64 %225, 3, !dbg !1557
  %229 = icmp ult i64 %224, 38, !dbg !1558
  %230 = select i1 %228, i1 %229, i1 false, !dbg !1558
  br i1 %230, label %223, label %258, !dbg !1559, !llvm.loop !1560

231:                                              ; preds = %221
  call void @llvm.dbg.value(metadata %struct.block* null, metadata !826, metadata !DIExpression()), !dbg !1562
  %232 = load %struct.block**, %struct.block*** @seglists, align 8, !dbg !1563, !tbaa !112
  %233 = load %struct.block*, %struct.block** %232, align 8, !dbg !1563, !tbaa !112
  call void @llvm.dbg.value(metadata %struct.block* %233, metadata !829, metadata !DIExpression()), !dbg !1562
  %234 = icmp ne %struct.block* %233, null, !dbg !1564
  %235 = icmp eq %struct.block* %233, %57
  %236 = and i1 %234, %235, !dbg !1565
  br i1 %236, label %240, label %237, !dbg !1565

237:                                              ; preds = %231
  call void @llvm.dbg.value(metadata %struct.block* null, metadata !826, metadata !DIExpression()), !dbg !1562
  call void @llvm.dbg.value(metadata %struct.block* %233, metadata !829, metadata !DIExpression()), !dbg !1562
  %238 = icmp ne %struct.block* %233, %57, !dbg !1566
  %239 = and i1 %234, %238, !dbg !1566
  br i1 %239, label %243, label %250, !dbg !1567

240:                                              ; preds = %231
  %241 = getelementptr inbounds %struct.block, %struct.block* %57, i64 0, i32 1, i32 0, i32 0, !dbg !1568
  %242 = load %struct.block*, %struct.block** %241, align 8, !dbg !1568, !tbaa !320
  store %struct.block* %242, %struct.block** %232, align 8, !dbg !1569, !tbaa !112
  br label %272, !dbg !1570

243:                                              ; preds = %237, %243
  %244 = phi %struct.block* [ %246, %243 ], [ %233, %237 ]
  call void @llvm.dbg.value(metadata %struct.block* %244, metadata !829, metadata !DIExpression()), !dbg !1562
  call void @llvm.dbg.value(metadata %struct.block* %244, metadata !826, metadata !DIExpression()), !dbg !1562
  %245 = getelementptr inbounds %struct.block, %struct.block* %244, i64 0, i32 1, i32 0, i32 0, !dbg !1571
  %246 = load %struct.block*, %struct.block** %245, align 8, !dbg !1571, !tbaa !320
  call void @llvm.dbg.value(metadata %struct.block* %246, metadata !829, metadata !DIExpression()), !dbg !1562
  %247 = icmp ne %struct.block* %246, null, !dbg !1572
  %248 = icmp ne %struct.block* %246, %57, !dbg !1566
  %249 = and i1 %247, %248, !dbg !1566
  br i1 %249, label %243, label %250, !dbg !1567, !llvm.loop !1573

250:                                              ; preds = %243, %237
  %251 = phi %struct.block* [ %233, %237 ], [ %246, %243 ], !dbg !1562
  %252 = phi %struct.block* [ null, %237 ], [ %244, %243 ], !dbg !1562
  %253 = icmp eq %struct.block* %251, null, !dbg !1575
  br i1 %253, label %272, label %254, !dbg !1576

254:                                              ; preds = %250
  %255 = getelementptr inbounds %struct.block, %struct.block* %251, i64 0, i32 1, i32 0, i32 0, !dbg !1577
  %256 = load %struct.block*, %struct.block** %255, align 8, !dbg !1577, !tbaa !320
  %257 = getelementptr inbounds %struct.block, %struct.block* %252, i64 0, i32 1, i32 0, i32 0, !dbg !1578
  store %struct.block* %256, %struct.block** %257, align 8, !dbg !1579, !tbaa !320
  br label %272, !dbg !1580

258:                                              ; preds = %223, %221
  %259 = phi i64 [ 1, %221 ], [ %226, %223 ]
  %260 = getelementptr inbounds %struct.block, %struct.block* %57, i64 0, i32 1, i32 0, i32 1, !dbg !1581
  %261 = load %struct.block*, %struct.block** %260, align 8, !dbg !1581, !tbaa !320
  call void @llvm.dbg.value(metadata %struct.block* %261, metadata !830, metadata !DIExpression()), !dbg !1546
  %262 = getelementptr inbounds %struct.block, %struct.block* %57, i64 0, i32 1, i32 0, i32 0, !dbg !1582
  %263 = load %struct.block*, %struct.block** %262, align 8, !dbg !1582, !tbaa !320
  call void @llvm.dbg.value(metadata %struct.block* %263, metadata !831, metadata !DIExpression()), !dbg !1546
  %264 = icmp eq %struct.block* %261, null, !dbg !1583
  %265 = load %struct.block**, %struct.block*** @seglists, align 8, !dbg !1584
  %266 = getelementptr inbounds %struct.block*, %struct.block** %265, i64 %259, !dbg !1584
  %267 = getelementptr inbounds %struct.block, %struct.block* %261, i64 0, i32 1, i32 0, i32 0, !dbg !1584
  %268 = select i1 %264, %struct.block** %266, %struct.block** %267, !dbg !1584
  store %struct.block* %263, %struct.block** %268, align 8, !dbg !1585, !tbaa !320
  %269 = icmp eq %struct.block* %263, null, !dbg !1586
  br i1 %269, label %272, label %270, !dbg !1587

270:                                              ; preds = %258
  %271 = getelementptr inbounds %struct.block, %struct.block* %263, i64 0, i32 1, i32 0, i32 1, !dbg !1588
  store %struct.block* %261, %struct.block** %271, align 8, !dbg !1589, !tbaa !320
  br label %272, !dbg !1590

272:                                              ; preds = %240, %250, %254, %258, %270
  %273 = phi %struct.block** [ %232, %240 ], [ %232, %250 ], [ %232, %254 ], [ %265, %258 ], [ %265, %270 ]
  %274 = load i64, i64* %58, align 8, !dbg !1591, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !720, metadata !DIExpression()), !dbg !1592
  call void @llvm.dbg.value(metadata i64 %274, metadata !725, metadata !DIExpression()), !dbg !1594
  %275 = and i64 %274, 2, !dbg !1596
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !731, metadata !DIExpression()), !dbg !1597
  call void @llvm.dbg.value(metadata i64 %274, metadata !736, metadata !DIExpression()), !dbg !1599
  %276 = and i64 %274, 4, !dbg !1601
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !496, metadata !DIExpression()), !dbg !1602
  call void @llvm.dbg.value(metadata i64 %222, metadata !501, metadata !DIExpression()), !dbg !1602
  call void @llvm.dbg.value(metadata i1 false, metadata !502, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1602
  call void @llvm.dbg.value(metadata i1 undef, metadata !503, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1602
  call void @llvm.dbg.value(metadata i1 undef, metadata !504, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1602
  call void @llvm.dbg.value(metadata i64 %222, metadata !454, metadata !DIExpression()), !dbg !1604
  call void @llvm.dbg.value(metadata i1 false, metadata !459, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1604
  call void @llvm.dbg.value(metadata i1 undef, metadata !460, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1604
  call void @llvm.dbg.value(metadata i1 undef, metadata !461, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1604
  call void @llvm.dbg.value(metadata i64 %222, metadata !462, metadata !DIExpression()), !dbg !1604
  %277 = or i64 %275, %222, !dbg !1606
  call void @llvm.dbg.value(metadata !DIArgList(i64 %275, i64 %222), metadata !462, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_or, DW_OP_stack_value)), !dbg !1604
  %278 = or i64 %277, %276, !dbg !1607
  call void @llvm.dbg.value(metadata !DIArgList(i64 %276, i64 %275, i64 %222), metadata !462, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_or, DW_OP_or, DW_OP_stack_value)), !dbg !1604
  store i64 %278, i64* %58, align 8, !dbg !1608, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !251, metadata !DIExpression()), !dbg !1609
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !1611
  call void @llvm.dbg.value(metadata !DIArgList(i64 %276, i64 %275, i64 %222), metadata !125, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_or, DW_OP_or, DW_OP_stack_value)), !dbg !1613
  %279 = icmp eq i64 %222, 16, !dbg !1615
  br i1 %279, label %288, label %280, !dbg !1616

280:                                              ; preds = %272
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !223, metadata !DIExpression()), !dbg !1617
  %281 = getelementptr inbounds %struct.block, %struct.block* %57, i64 0, i32 1, !dbg !1619
  %282 = bitcast %union.anon* %281 to i8*, !dbg !1620
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !1621
  call void @llvm.dbg.value(metadata !DIArgList(i64 %276, i64 %275, i64 %222), metadata !125, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_or, DW_OP_or, DW_OP_stack_value)), !dbg !1623
  %283 = getelementptr inbounds i8, i8* %282, i64 %222, !dbg !1625
  %284 = getelementptr inbounds i8, i8* %283, i64 -16, !dbg !1626
  %285 = bitcast i8* %284 to i64*, !dbg !1627
  call void @llvm.dbg.value(metadata i64* %285, metadata !505, metadata !DIExpression()), !dbg !1628
  call void @llvm.dbg.value(metadata i64 %222, metadata !454, metadata !DIExpression()), !dbg !1629
  call void @llvm.dbg.value(metadata i1 false, metadata !459, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1629
  call void @llvm.dbg.value(metadata i1 undef, metadata !460, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1629
  call void @llvm.dbg.value(metadata i1 undef, metadata !461, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1629
  call void @llvm.dbg.value(metadata !DIArgList(i64 %276, i64 %275, i64 %222), metadata !462, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_or, DW_OP_or, DW_OP_stack_value)), !dbg !1629
  store i64 %278, i64* %285, align 8, !dbg !1631, !tbaa !94
  %286 = load i64, i64* %58, align 8, !dbg !1632, !tbaa !116
  %287 = and i64 %286, -16, !dbg !1634
  br label %288, !dbg !1637

288:                                              ; preds = %272, %280
  %289 = phi i64 [ %287, %280 ], [ 16, %272 ], !dbg !1634
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !181, metadata !DIExpression()), !dbg !1638
  %290 = bitcast %struct.block* %57 to i8*, !dbg !1639
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !1640
  call void @llvm.dbg.value(metadata !DIArgList(i64 %276, i64 %275, i64 %222), metadata !125, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_or, DW_OP_or, DW_OP_stack_value)), !dbg !1641
  %291 = getelementptr inbounds i8, i8* %290, i64 %289, !dbg !1642
  %292 = bitcast i8* %291 to i64*, !dbg !1643
  %293 = load i64, i64* %292, align 8, !dbg !1644, !tbaa !116
  %294 = and i64 %293, -3, !dbg !1644
  store i64 %294, i64* %292, align 8, !dbg !1644, !tbaa !116
  %295 = load i64, i64* %58, align 8, !dbg !1645, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !251, metadata !DIExpression()), !dbg !1646
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !1648
  call void @llvm.dbg.value(metadata i64 %295, metadata !125, metadata !DIExpression()), !dbg !1650
  %296 = and i64 %295, -16, !dbg !1652
  %297 = icmp eq i64 %296, 16, !dbg !1653
  %298 = and i64 %293, -7, !dbg !1654
  %299 = select i1 %297, i64 4, i64 0, !dbg !1654
  %300 = or i64 %299, %298, !dbg !1654
  store i64 %300, i64* %292, align 8, !dbg !1655, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !1098, metadata !DIExpression()), !dbg !1656
  %301 = load i64, i64* %58, align 8, !dbg !1658, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !1659
  call void @llvm.dbg.value(metadata i64 %301, metadata !125, metadata !DIExpression()), !dbg !1661
  %302 = and i64 %301, -16, !dbg !1663
  call void @llvm.dbg.value(metadata i64 %302, metadata !334, metadata !DIExpression()), !dbg !1664
  switch i64 %302, label %303 [
    i64 16, label %311
    i64 0, label %314
  ], !dbg !1666

303:                                              ; preds = %288, %303
  %304 = phi i64 [ %306, %303 ], [ 1, %288 ]
  %305 = phi i64 [ %307, %303 ], [ %302, %288 ]
  call void @llvm.dbg.value(metadata i64 %304, metadata !339, metadata !DIExpression()), !dbg !1664
  call void @llvm.dbg.value(metadata i64 %305, metadata !334, metadata !DIExpression()), !dbg !1664
  %306 = add nuw nsw i64 %304, 1, !dbg !1667
  call void @llvm.dbg.value(metadata i64 %306, metadata !339, metadata !DIExpression()), !dbg !1664
  %307 = lshr i64 %305, 1, !dbg !1668
  call void @llvm.dbg.value(metadata i64 %307, metadata !334, metadata !DIExpression()), !dbg !1664
  %308 = icmp ugt i64 %305, 3, !dbg !1669
  %309 = icmp ult i64 %304, 38, !dbg !1670
  %310 = select i1 %308, i1 %309, i1 false, !dbg !1670
  br i1 %310, label %303, label %314, !dbg !1671, !llvm.loop !1672

311:                                              ; preds = %288
  %312 = load %struct.block*, %struct.block** %273, align 8, !dbg !1674, !tbaa !112
  %313 = getelementptr inbounds %struct.block, %struct.block* %57, i64 0, i32 1, i32 0, i32 0, !dbg !1675
  store %struct.block* %312, %struct.block** %313, align 8, !dbg !1676, !tbaa !320
  br label %324, !dbg !1677

314:                                              ; preds = %303, %288
  %315 = phi i64 [ 1, %288 ], [ %306, %303 ]
  %316 = getelementptr inbounds %struct.block*, %struct.block** %273, i64 %315, !dbg !1678
  %317 = load %struct.block*, %struct.block** %316, align 8, !dbg !1678, !tbaa !112
  %318 = getelementptr inbounds %struct.block, %struct.block* %57, i64 0, i32 1, i32 0, i32 0, !dbg !1679
  store %struct.block* %317, %struct.block** %318, align 8, !dbg !1680, !tbaa !320
  %319 = getelementptr inbounds %struct.block, %struct.block* %57, i64 0, i32 1, i32 0, i32 1, !dbg !1681
  store %struct.block* null, %struct.block** %319, align 8, !dbg !1682, !tbaa !320
  %320 = load %struct.block*, %struct.block** %316, align 8, !dbg !1683, !tbaa !112
  %321 = icmp eq %struct.block* %320, null, !dbg !1684
  br i1 %321, label %324, label %322, !dbg !1685

322:                                              ; preds = %314
  %323 = getelementptr inbounds %struct.block, %struct.block* %320, i64 0, i32 1, i32 0, i32 1, !dbg !1686
  store %struct.block* %57, %struct.block** %323, align 8, !dbg !1687, !tbaa !320
  br label %324, !dbg !1688

324:                                              ; preds = %311, %314, %322
  %325 = phi %struct.block** [ %273, %311 ], [ %316, %322 ], [ %316, %314 ]
  store %struct.block* %57, %struct.block** %325, align 8, !dbg !1656, !tbaa !112
  br label %433, !dbg !1689

326:                                              ; preds = %29
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !1690
  call void @llvm.dbg.value(metadata i64 %11, metadata !125, metadata !DIExpression()), !dbg !1694
  %327 = and i64 %11, -16, !dbg !1696
  %328 = add i64 %327, %5, !dbg !1697
  call void @llvm.dbg.value(metadata i64 %328, metadata !1222, metadata !DIExpression()), !dbg !1223
  call void @llvm.dbg.value(metadata %struct.block* %7, metadata !822, metadata !DIExpression()), !dbg !1698
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !118, metadata !DIExpression()), !dbg !1700
  call void @llvm.dbg.value(metadata i64 %11, metadata !125, metadata !DIExpression()), !dbg !1702
  call void @llvm.dbg.value(metadata i64 %327, metadata !334, metadata !DIExpression()), !dbg !1704
  switch i64 %327, label %329 [
    i64 16, label %337
    i64 0, label %365
  ], !dbg !1706

329:                                              ; preds = %326, %329
  %330 = phi i64 [ %332, %329 ], [ 1, %326 ]
  %331 = phi i64 [ %333, %329 ], [ %327, %326 ]
  call void @llvm.dbg.value(metadata i64 %330, metadata !339, metadata !DIExpression()), !dbg !1704
  call void @llvm.dbg.value(metadata i64 %331, metadata !334, metadata !DIExpression()), !dbg !1704
  %332 = add nuw nsw i64 %330, 1, !dbg !1707
  call void @llvm.dbg.value(metadata i64 %332, metadata !339, metadata !DIExpression()), !dbg !1704
  %333 = lshr i64 %331, 1, !dbg !1708
  call void @llvm.dbg.value(metadata i64 %333, metadata !334, metadata !DIExpression()), !dbg !1704
  %334 = icmp ugt i64 %331, 3, !dbg !1709
  %335 = icmp ult i64 %330, 38, !dbg !1710
  %336 = select i1 %334, i1 %335, i1 false, !dbg !1710
  br i1 %336, label %329, label %365, !dbg !1711, !llvm.loop !1712

337:                                              ; preds = %326
  call void @llvm.dbg.value(metadata %struct.block* null, metadata !826, metadata !DIExpression()), !dbg !1714
  %338 = load %struct.block**, %struct.block*** @seglists, align 8, !dbg !1715, !tbaa !112
  %339 = load %struct.block*, %struct.block** %338, align 8, !dbg !1715, !tbaa !112
  call void @llvm.dbg.value(metadata %struct.block* %339, metadata !829, metadata !DIExpression()), !dbg !1714
  %340 = icmp ne %struct.block* %339, null, !dbg !1716
  %341 = icmp eq %struct.block* %339, %7
  %342 = and i1 %340, %341, !dbg !1717
  br i1 %342, label %346, label %343, !dbg !1717

343:                                              ; preds = %337
  call void @llvm.dbg.value(metadata %struct.block* null, metadata !826, metadata !DIExpression()), !dbg !1714
  call void @llvm.dbg.value(metadata %struct.block* %339, metadata !829, metadata !DIExpression()), !dbg !1714
  %344 = icmp ne %struct.block* %339, %7, !dbg !1718
  %345 = and i1 %340, %344, !dbg !1718
  br i1 %345, label %350, label %357, !dbg !1719

346:                                              ; preds = %337
  %347 = getelementptr inbounds i8, i8* %6, i64 8, !dbg !1720
  %348 = bitcast i8* %347 to %struct.block**, !dbg !1720
  %349 = load %struct.block*, %struct.block** %348, align 8, !dbg !1720, !tbaa !320
  store %struct.block* %349, %struct.block** %338, align 8, !dbg !1721, !tbaa !112
  br label %381, !dbg !1722

350:                                              ; preds = %343, %350
  %351 = phi %struct.block* [ %353, %350 ], [ %339, %343 ]
  call void @llvm.dbg.value(metadata %struct.block* %351, metadata !829, metadata !DIExpression()), !dbg !1714
  call void @llvm.dbg.value(metadata %struct.block* %351, metadata !826, metadata !DIExpression()), !dbg !1714
  %352 = getelementptr inbounds %struct.block, %struct.block* %351, i64 0, i32 1, i32 0, i32 0, !dbg !1723
  %353 = load %struct.block*, %struct.block** %352, align 8, !dbg !1723, !tbaa !320
  call void @llvm.dbg.value(metadata %struct.block* %353, metadata !829, metadata !DIExpression()), !dbg !1714
  %354 = icmp ne %struct.block* %353, null, !dbg !1724
  %355 = icmp ne %struct.block* %353, %7, !dbg !1718
  %356 = and i1 %354, %355, !dbg !1718
  br i1 %356, label %350, label %357, !dbg !1719, !llvm.loop !1725

357:                                              ; preds = %350, %343
  %358 = phi %struct.block* [ %339, %343 ], [ %353, %350 ], !dbg !1714
  %359 = phi %struct.block* [ null, %343 ], [ %351, %350 ], !dbg !1714
  %360 = icmp eq %struct.block* %358, null, !dbg !1727
  br i1 %360, label %381, label %361, !dbg !1728

361:                                              ; preds = %357
  %362 = getelementptr inbounds %struct.block, %struct.block* %358, i64 0, i32 1, i32 0, i32 0, !dbg !1729
  %363 = load %struct.block*, %struct.block** %362, align 8, !dbg !1729, !tbaa !320
  %364 = getelementptr inbounds %struct.block, %struct.block* %359, i64 0, i32 1, i32 0, i32 0, !dbg !1730
  store %struct.block* %363, %struct.block** %364, align 8, !dbg !1731, !tbaa !320
  br label %381, !dbg !1732

365:                                              ; preds = %329, %326
  %366 = phi i64 [ 1, %326 ], [ %332, %329 ]
  %367 = getelementptr inbounds i8, i8* %6, i64 16, !dbg !1733
  %368 = bitcast i8* %367 to %struct.block**, !dbg !1733
  %369 = load %struct.block*, %struct.block** %368, align 8, !dbg !1733, !tbaa !320
  call void @llvm.dbg.value(metadata %struct.block* %369, metadata !830, metadata !DIExpression()), !dbg !1698
  %370 = getelementptr inbounds i8, i8* %6, i64 8, !dbg !1734
  %371 = bitcast i8* %370 to %struct.block**, !dbg !1734
  %372 = load %struct.block*, %struct.block** %371, align 8, !dbg !1734, !tbaa !320
  call void @llvm.dbg.value(metadata %struct.block* %372, metadata !831, metadata !DIExpression()), !dbg !1698
  %373 = icmp eq %struct.block* %369, null, !dbg !1735
  %374 = load %struct.block**, %struct.block*** @seglists, align 8, !dbg !1736
  %375 = getelementptr inbounds %struct.block*, %struct.block** %374, i64 %366, !dbg !1736
  %376 = getelementptr inbounds %struct.block, %struct.block* %369, i64 0, i32 1, i32 0, i32 0, !dbg !1736
  %377 = select i1 %373, %struct.block** %375, %struct.block** %376, !dbg !1736
  store %struct.block* %372, %struct.block** %377, align 8, !dbg !1737, !tbaa !320
  %378 = icmp eq %struct.block* %372, null, !dbg !1738
  br i1 %378, label %381, label %379, !dbg !1739

379:                                              ; preds = %365
  %380 = getelementptr inbounds %struct.block, %struct.block* %372, i64 0, i32 1, i32 0, i32 1, !dbg !1740
  store %struct.block* %369, %struct.block** %380, align 8, !dbg !1741, !tbaa !320
  br label %381, !dbg !1742

381:                                              ; preds = %346, %357, %361, %365, %379
  %382 = phi %struct.block** [ %338, %346 ], [ %338, %357 ], [ %338, %361 ], [ %374, %365 ], [ %374, %379 ]
  %383 = load i64, i64* %3, align 8, !dbg !1743, !tbaa !116
  call void @llvm.dbg.value(metadata %struct.block* undef, metadata !731, metadata !DIExpression()), !dbg !1744
  call void @llvm.dbg.value(metadata i64 %383, metadata !736, metadata !DIExpression()), !dbg !1746
  %384 = and i64 %383, 4, !dbg !1748
  call void @llvm.dbg.value(metadata %struct.block* %0, metadata !496, metadata !DIExpression()), !dbg !1749
  call void @llvm.dbg.value(metadata i64 %328, metadata !501, metadata !DIExpression()), !dbg !1749
  call void @llvm.dbg.value(metadata i1 false, metadata !502, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1749
  call void @llvm.dbg.value(metadata i1 true, metadata !503, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1749
  call void @llvm.dbg.value(metadata i1 undef, metadata !504, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !1749
  call void @llvm.dbg.value(metadata i64 %328, metadata !454, metadata !DIExpression()), !dbg !1751
  call void @llvm.dbg.value(metadata i1 false, metadata !459, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_valu