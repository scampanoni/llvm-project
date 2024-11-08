; Check the linkage types in both the per-module and combined summaries.
; RUN: opt -module-summary %s -o %t.o
; RUN: llvm-bcanalyzer -dump %t.o | FileCheck %s
; RUN: llvm-lto -thinlto -o %t2 %t.o
; RUN: llvm-bcanalyzer -dump %t2.thinlto.bc | FileCheck %s --check-prefix=COMBINED

; Flags should be 0x47 (71) for local linkage (0x3), dso_local (0x40) and being importable
; (0x10) due to local linkage plus having a section.
; CHECK: <PERMODULE_PROFILE {{.*}} op1=71
; COMBINED-DAG: <COMBINED_PROFILE {{.*}} op2=71
define internal void @functionWithSection() section "some_section" {
    ret void
}
