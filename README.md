## workshop-survey-analysis

Analyze the results of pre/post Carpentries workshop surveys

Set up for surveys conducted in Japanese

For reference, here is the [pre-workshop survey](https://carpentries.typeform.com/to/CvmMM8re) and [post-workshop survey](https://carpentries.typeform.com/to/hIg7dK3r)

### Reproducible analysis

This project uses [nix](https://nixos.org/) to maintain a reproducible environment.

After installing nix, use this command to run the pipeline:

```
nix-shell default.nix --run "Rscript -e 'targets::tar_make()'"
```

### License

workshop-survey-analysis (c) by Joel H. Nitta

workshop-survey-analysis is licensed under a
Creative Commons Attribution 4.0 International License.

You should have received a copy of the license along with this
work. If not, see <https://creativecommons.org/licenses/by/4.0/>.

