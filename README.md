Somewhat minimized example of <https://github.com/JuliaPy/PythonCall.jl/issues/563> where I get segfault with julia 1.11 but not with julia 1.10

Running `julia --project=. reproducer.jl` non-deterministically produces a segfault. Usually reproducable with just a handful of runs.

Example stacktrace:

```
[219060] signal 11 (1): Segmentation fault
in expression starting at $REPO/reproducer.jl:28
lookup_tp_mro at /usr/local/src/conda/python-3.12.5/Objects/typeobject.c:336 [inlined]
PyType_IsSubtype at /usr/local/src/conda/python-3.12.5/Objects/typeobject.c:2127 [inlined]
PyObject_TypeCheck at /usr/local/src/conda/python-3.12.5/Include/object.h:381 [inlined]
object_isinstance at /usr/local/src/conda/python-3.12.5/Objects/abstract.c:2571
_PyEval_EvalFrameDefault at /home/conda/feedstock_root/build_artifacts/python-split_1723141048588/work/build-shared/Python/bytecodes.c:3035
_PyEval_EvalFrame at /usr/local/src/conda/python-3.12.5/Include/internal/pycore_ceval.h:89 [inlined]
_PyEval_Vector at /usr/local/src/conda/python-3.12.5/Python/ceval.c:1683 [inlined]
_PyFunction_Vectorcall at /usr/local/src/conda/python-3.12.5/Objects/call.c:419 [inlined]
_PyObject_VectorcallTstate at /usr/local/src/conda/python-3.12.5/Include/internal/pycore_call.h:92 [inlined]
method_vectorcall at /usr/local/src/conda/python-3.12.5/Objects/classobject.c:91
PyObject_CallObject at $HOME/.julia/packages/PythonCall/Nr75f/src/C/pointers.jl:303 [inlined]
macro expansion at $HOME/.julia/packages/PythonCall/Nr75f/src/Core/Py.jl:132 [inlined]
pycallargs at $HOME/.julia/packages/PythonCall/Nr75f/src/Core/builtins.jl:220
#pycall#21 at $HOME/.julia/packages/PythonCall/Nr75f/src/Core/builtins.jl:243 [inlined]
pycall at $HOME/.julia/packages/PythonCall/Nr75f/src/Core/builtins.jl:233 [inlined]
#_#11 at $HOME/.julia/packages/PythonCall/Nr75f/src/Core/Py.jl:357 [inlined]
Py at $HOME/.julia/packages/PythonCall/Nr75f/src/Core/Py.jl:357 [inlined]
#1 at $REPO/reproducer.jl:12 [inlined]
#4 at $REPO/reproducer.jl:21
evalrule at $HOME/.julia/packages/QuadGK/BjmU0/src/evalrule.jl:32
refine at $HOME/.julia/packages/QuadGK/BjmU0/src/adapt.jl:114
adapt at $HOME/.julia/packages/QuadGK/BjmU0/src/adapt.jl:96 [inlined]
do_quadgk at $HOME/.julia/packages/QuadGK/BjmU0/src/adapt.jl:87
#50 at $HOME/.julia/packages/QuadGK/BjmU0/src/api.jl:83 [inlined]
handle_infinities at $HOME/.julia/packages/QuadGK/BjmU0/src/adapt.jl:189 [inlined]
#quadgk#49 at $HOME/.julia/packages/QuadGK/BjmU0/src/api.jl:82 [inlined]
quadgk at $HOME/.julia/packages/QuadGK/BjmU0/src/api.jl:80 [inlined]
#3 at $REPO/reproducer.jl:23 [inlined]
_broadcast_getindex_evalf at ./broadcast.jl:673 [inlined]
_broadcast_getindex at ./broadcast.jl:646 [inlined]
getindex at ./broadcast.jl:605 [inlined]
macro expansion at ./broadcast.jl:968 [inlined]
macro expansion at ./simdloop.jl:77 [inlined]
copyto! at ./broadcast.jl:967 [inlined]
copyto! at ./broadcast.jl:920 [inlined]
copy at ./broadcast.jl:892 [inlined]
materialize at ./broadcast.jl:867
unknown function (ip: 0x7f438a6e1ce2)
jl_apply at /cache/build/builder-demeter6-6/julialang/julia-master/src/julia.h:2157 [inlined]
do_call at /cache/build/builder-demeter6-6/julialang/julia-master/src/interpreter.c:126
eval_value at /cache/build/builder-demeter6-6/julialang/julia-master/src/interpreter.c:223
eval_body at /cache/build/builder-demeter6-6/julialang/julia-master/src/interpreter.c:562
eval_body at /cache/build/builder-demeter6-6/julialang/julia-master/src/interpreter.c:539
jl_interpret_toplevel_thunk at /cache/build/builder-demeter6-6/julialang/julia-master/src/interpreter.c:821
jl_toplevel_eval_flex at /cache/build/builder-demeter6-6/julialang/julia-master/src/toplevel.c:943
jl_toplevel_eval_flex at /cache/build/builder-demeter6-6/julialang/julia-master/src/toplevel.c:886
ijl_toplevel_eval_in at /cache/build/builder-demeter6-6/julialang/julia-master/src/toplevel.c:994
eval at ./boot.jl:430 [inlined]
include_string at ./loading.jl:2643
_include at ./loading.jl:2703
include at ./Base.jl:557
jfptr_include_46643.1 at [redacted]/julia-1.11.1/lib/julia/sys.so (unknown line)
exec_options at ./client.jl:323
_start at ./client.jl:531
jfptr__start_72144.1 at [redacted]/julia-1.11.1/lib/julia/sys.so (unknown line)
jl_apply at /cache/build/builder-demeter6-6/julialang/julia-master/src/julia.h:2157 [inlined]
true_main at /cache/build/builder-demeter6-6/julialang/julia-master/src/jlapi.c:900
jl_repl_entrypoint at /cache/build/builder-demeter6-6/julialang/julia-master/src/jlapi.c:1059
main at julia (unknown line)
unknown function (ip: 0x7f438bb6d42d)
__libc_start_main at /usr/lib64/libc.so.6 (unknown line)
unknown function (ip: 0x4010b8)
Allocations: 11794097 (Pool: 11793774; Big: 323); GC: 9
```
