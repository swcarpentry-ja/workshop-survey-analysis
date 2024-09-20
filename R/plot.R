create_comp_plot <- function(pre_clean, post_clean) {
  common_cols <- intersect(
    colnames(pre_clean),
    colnames(post_clean)
  )

  pre_sub <-
    pre_clean |>
    select(all_of(common_cols)) |>
    unique() |>
    mutate(when = "pre")

  post_sub <-
    post_clean |>
    select(all_of(common_cols)) |>
    mutate(when = "post")

  combined <-
    bind_rows(
      pre_sub,
      post_sub
    )

  combined |>
    rename(
      `元の生データにアクセスできることは、\n分析を再現するために重要である。` = data_access,
      `仕事上、小さなプログラム、スクリプト\nもしくはマクロを問題解決のために\n作成することが出来る。` = can_make_program,
      `技術的な質問の答えをオンラインで\n探す方法が分かる。` = can_find_help,
      `プログラミングをしていて行き詰った\nときに、その問題を解決する手法を\n見つけることが出来る。` = can_fix_program,
      `自分のプログラミングソフトウェアによる\nデータ解析能力に自信がある。` = confident_data_analysis,
      `プログラミング言語（RやPythonなど）\nを使うことで、自分の分析をより再現\nしやすくすることができる。` = can_reproduce,
      `プログラミング言語（RやPythonなど）\nを使用することで、データの処理をより\n効率的に行うことができる。` = can_make_efficient
    ) |>
    select(-id) |>
    pivot_longer(names_to = "question", values_to = "response", -when) |>
    filter(!is.na(response)) |>
    mutate(
      response = factor(response, levels = c(1:5)) |>
        fct_recode(
          "全くそう思わない（1）" = "1",
          "どちらでもない（3）" = "3",
          "強くそう思う（5）" = "5")
    ) |>
    ggplot(aes(x = response, fill = when)) +
    geom_bar(position = position_dodge(preserve = "single")) +
    scale_fill_manual(
      labels = c("前", "後"),
      breaks = c("pre", "post"),
      values = c(
        pre = "#ef8a62", # red
        post = "#67a9cf" # blue
      )
    ) +
    coord_flip() +
    labs(
      subtitle = glue::glue(
        "前調査 n = {nrow(pre_sub)}人、後調査 n = {nrow(post_sub)}人"),
      y = "回答の数",
      fill = "時点"
    ) +
    facet_wrap(~question, labeller = label_wrap_gen(width = 5)) +
    theme_gray(base_family = "HiraKakuPro-W3") +
    theme(
      axis.title.y = element_blank(),
      plot.subtitle = element_markdown(),
      strip.text = element_text(size = 6)
    )
}
