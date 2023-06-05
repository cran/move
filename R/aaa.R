.onAttach<-function(lib, pkg){
  if(interactive())
  {packageStartupMessage("Currently a successor to `move` is being developed (`move2`, https://bartk.gitlab.io/move2/). This should bring speed improvements and is based on `sf`. Feedback (including missing functionality) on this new package that is soon to be released to CRAN is welcome and for new projects it might be worth considering starting with `move2`.")}
  invisible()
}
