source("./progress.R")

NB_ITER = 20
pb <- create_pb(NB_ITER)
for (i in 1:NB_ITER) {
    update_pb(pb,i)
    Sys.sleep(0.5)
}

NB_ITER = 1000
pb <- create_pb(NB_ITER, bar_style="simple", time_style="cd")
for (i in 1:NB_ITER) {
    update_pb(pb,i)
    Sys.sleep(0.5)
}

NB_ITER = 10000
pb <- create_pb(NB_ITER, bar_style="pc", time_style="end")
for (i in 1:NB_ITER) {
    update_pb(pb,i)
    Sys.sleep(0.5)
}
