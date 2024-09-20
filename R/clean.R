pivot_answer <- function(survey_data, col_name, ...) {
  survey_data_sub <- tryCatch(
  {
    survey_data |>
      select(id, ...)
  },
  error = function(e) {
    # Return a tibble with zero rows and the same column names as survey_data
    tibble(id = character())
  }
  )

  if (nrow(survey_data_sub) == 0) return(survey_data_sub)

  survey_data_sub |>
    pivot_longer(names_to = col_name, cols = -id) |>
    filter(!is.na(value)) |>
    filter(!is.na(id)) |>
    select(-value)
}

select_answer <- function(survey_data, col_name, text) {

  survey_data_sub <-
    survey_data |>
      select(id, matches(text))

  if (length(colnames(survey_data_sub)) == 1 && colnames(survey_data_sub) == "id") return(tibble(id = character()))

  survey_data_sub |>
    select(id, {{ col_name }} := matches(text))
}

clean_survey <- function(survey_raw) {

  survey <- survey_raw |>
    rename(id = matches("固有の ID ")) |>
    filter(!is.na(id))

  ids <- select(survey, id)

  parsed <- list(
    ids, 
  q03 = select_answer(survey, "workshop", "どのワークショップに参加"),

  q05 = pivot_answer(survey, "specialty", 農業もしくは環境科学:Other...24),

  q06 = pivot_answer(survey, "career", 事務職:Other...39),

  q07 = select_answer(survey, "os", "オペレーティングシステムを教えてください"),

  q08 = select_answer(
    survey, "gui_usage", "グラフィックユーザーインターフェースに特化したソフトウェア"),

  q09 = select_answer(
    survey, "programming_usage", "プログラム言語 (R、パイソンなど)"),

  q10 = select_answer(
    survey, "database_usage", "データベース (SQL、アクセスなど)"),

  q11 = select_answer(
    survey, "version_usage", "バージョン管理ソフトウェア (Git、Subversion (SVN)、Mercurial、など)"),

  q12 = select_answer(
    survey, "command_line_usage", "コマンドシェル (通常マック OS やウィンドウズのパワーシェルを介してターミナルにアクセス)"),

  q13 = select_answer(
    survey, "data_management_satisfaction", "あなたの現在のデータマネジメントと解析に関するワークフロー"
  ),

  q14 = pivot_answer(
    survey, "join_reason", matches("新しいスキルを習得するため"):Other...53
  ),

  q15 = pivot_answer(
    survey, "how_find", matches("ワークショップに関する E メールもしくはチラシを受け取った"):Other...62
  ),

  q16 = select_answer(
    survey, "data_access", "元の生データにアクセスできることは"),

  q17 = select_answer(
    survey, "can_make_program", "仕事上、小さなプログラム、スクリプトもしくは"),

  q18 = select_answer(
    survey, "can_find_help", "技術的な質問の答えをオンラインで探す方法が分かる"),

  q19 = select_answer(
    survey, "can_fix_program", "プログラミングをしていて行き詰ったとき"),

  q20 = select_answer(
    survey, "confident_data_analysis", "自分のプログラミングソフトウェアによるデータ解析能力"),

  q21 = select_answer(
    survey, "can_reproduce", "プログラミング言語（RやPythonなど）を使うことで、自分の分析をより再現"),

  q22 = select_answer(
    survey, "can_make_efficient", "プログラミング言語（RやPythonなど）を使用することで、データの処理をより効率的に行うことができる"),

  q23 = select_answer(
    survey, "want_to_learn", "このワークショップから学びたいことを教えてください")
  )

  purrr::reduce(
    parsed, ~left_join(.x, .y, by = "id")
  )

}
