# Load packages
source("./packages.R")

# Load functions
lapply(list.files("./R", full.names = TRUE), source)

tar_option_set(
  workspace_on_error = TRUE
)

# Plan
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
  combined = combine_pre_post(pre_clean, post_clean),
  comp_bar_plot = create_comp_bar_plot(combined),
  comp_line_plot = create_comp_line_plot(combined),
  tar_file(
    comp_bar_plot_out,
    ggsave_tar(
      filename = "2024-05-30_chiba_survey_comp_bar.png",
      plot = comp_bar_plot,
      path = "results/",
      height = 29.7,
      width = 20,
      units = "cm"
    )
  ),
  tar_file(
    comp_line_plot_out,
    ggsave_tar(
      filename = "2024-05-30_chiba_survey_comp_line.png",
      plot = comp_line_plot,
      path = "results/",
      height = 29.7,
      width = 20,
      units = "cm"
    )
  ),
)
