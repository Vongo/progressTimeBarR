wideScreen <- function(howWide) {
   options(width=as.integer(howWide))
}

create_pb <- function(nb_iter,
                    bar_style=sample(c("simple","pc"),1),
                    time_style=sample(c("cd","end"),1)) {
    ret <- list()
    ret$dep_time <- Sys.time()
    ret$tot_iter <- nb_iter
    ret$bar_style <- bar_style
    ret$time_style <- time_style

    ret
}

update_pb <- function(pb,index) {
    terminal_width <- as.numeric(strsplit(system('stty size', intern=T), ' ')[[1]])[2]
    wideScreen(terminal_width)

    # Compute progress
    cur_iter <- index
    progress <- index/pb$tot_iter
    elapsed <- Sys.time() - pb$dep_time

    # Prepare time display
    total_time <- (elapsed/progress)
    exp_end <- pb$dep_time + total_time
    rmg_time <- exp_end - Sys.time()
    time <- if(pb$time_style=="cd")
        round(rmg_time,2)
    else
        exp_end
    time_width <- nchar(as.character(time))

    # Prepare bar display
    bar_width <- ifelse(pb$bar_style=="simple",terminal_width-time_width-6,terminal_width-time_width-10)
    bar_nb <- floor(progress*bar_width)

    bar <- if (pb$bar_style == "simple")
        paste("|",paste(rep("=",bar_nb),collapse=""),
            ifelse(bar_nb>0 & bar_nb<bar_width,">",""),
            paste(rep(" ",bar_width-bar_nb),collapse=""),"| ",sep="")
    else
        paste("|",paste(rep("=",bar_nb),collapse=""),
            ifelse(bar_nb>0 & bar_nb<bar_width,">",""),
            paste(rep(" ",bar_width-bar_nb),collapse=""),"| ",
            floor(100*progress),"% | ",sep="")

    # Display
    cat(paste("\r",paste(rep(" ",terminal_width),collapse=""),sep=""))
    cat(paste("\r",bar,time,sep=""))
}
