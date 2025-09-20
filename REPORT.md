# REPORT for BSDSF23A027-OS-A01

**Author:** Waqar Ali (replace with your email if needed)

## Part 2 — Linking rule
The recipe `$(TARGET): $(OBJECTS)` means the target binary depends on object files. `make` will ensure these object files are up-to-date before running the linker to create the target. When linking to a library, the linker uses the archive (`.a`) or shared object (`.so`) instead of individual `.o` files, allowing re-use of compiled code and faster incremental builds.

## Part 3 — Static library (ar / ranlib)
We created a static library `lib/libmyutils.a` using `ar rcs`. `ar` packs object files into an archive; `ranlib` (or `ar rcs`) generates an index inside the archive so the linker can quickly find symbols.

**Archive contents (ar -t):**
\`\`\`
$AR_T
\`\`\`

**Symbol check (nm):**
\`\`\`
$NM_MYSTR
\`\`\`

## Part 4 — Shared library (.so) and dynamic linking
We built `lib/libmyutils.so` using `-fPIC -shared`. `-fPIC` creates position-independent code required for shared objects. At runtime the dynamic loader searches for dependent `.so` files; `LD_LIBRARY_PATH` can be used during testing to point to the local `lib/`.

**Dynamic dependencies (ldd):**
\`\`\`
$LDD_BIN
\`\`\`

**Interpreter embedded (readelf INTERP):**
\`\`\`
$READELF_INTERP
\`\`\`

## Binary sizes comparison
\`\`\`
$LS_BIN
\`\`\`

Typically the static binary is larger because it embeds library code; the dynamic binary is smaller and depends on the shared library at runtime.

## Program output (sample run of ./bin/client)
\`\`\`
$CLIENT_RUN
\`\`\`

## Part 5 — install & man pages
`make install` copies `bin/client_dynamic` to `/usr/local/bin/client` and man pages to `/usr/local/share/man/man1` or `man3`. After running `sudo make install` run `man client` and `man mystrfunctions` to verify.

## Commands used to produce this report
- `make multifile`, `make static`, `make dynamic`, `make install`
- `ar -t lib/libmyutils.a`
- `nm -C lib/libmyutils.a | grep mystrlen`
- `ldd bin/client_dynamic`
- `readelf -l bin/client_dynamic | grep INTERP -i`
- `ls -lh bin/client_static bin/client_dynamic`

## Branches / tags / releases
Branches used: `multifile-build`, `static-build`, `dynamic-build`, `man-pages`  
Final tag: `v0.4.1-final` (attach binaries in GitHub Release)

