## Load your packages, e.g. library(targets).
source("./packages.R")

## Load your R files
lapply(list.files("./R", full.names = TRUE), source)

tar_option_set(
  workspace_on_error = TRUE
)


## tar_plan supports drake-style targets and also tar_target()
tar_plan(
  tar_file_read(
    pre_raw,
    "data/2024-05-30-chiba_pre_responses.csv",
    read_csv(!!.x)
  ),
  tar_file_read(
    post_raw,
    "data/2024-05-30-chiba_post_responses.csv",
    read_csv(!!.x)
  ),
  pre_clean = clean_survey(pre_raw),
  post_clean = clean_survey(post_raw),
  comp_plot = create_comp_plot(pre_clean, post_clean),
  tar_file(
    comp_plot_file,
    ggsave_tar(
      filename = "2024-05-30_chiba_survey.png",
      plot = comp_plot,
      path = "results/",
      height = 29.7,
      width = 20,
      units = "cm"
    )
  )
)
