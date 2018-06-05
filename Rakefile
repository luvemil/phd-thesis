require 'rake/clean'

LATEX_TEXT = FileList["*.tex", "FrontBackmatter/*.tex", "Chapters/*.tex"]
CLEAN.include(FileList["*.aux", "*.bbl", "*.blg", "*.brf", "*.idx", "*.ilg", "*.ind", "*.log"])

namespace :main do

  desc "main pdf"
  file "ClassicThesis.pdf" => ["ClassicThesis.tex", "Bibliography.bib", "version.tex", "classicthesis.sty"] + LATEX_TEXT do |f|
    sh "pdflatex ClassicThesis"
    sh "biber ClassicThesis"
    sh "pdflatex ClassicThesis"
    sh "pdflatex ClassicThesis"
  end

  desc "write version text"
  task "version" do |f|
    version_string = `git describe --tags | tr -d '\n'`
    current_version_string = `cat version.txt`
    if version_string != current_version_string
      File.open "version.txt", "w" do |output|
        p "writing version #{version_string}"
        output.write version_string
      end
    end
  end

  desc "write version file"
  file "version.tex" => "main:version" do |f|
    version_string = `cat version.txt`
    current_version_string = `cat #{f.name}`
    output_string = "\\newcommand{\\myVersion}{#{version_string}}"
    if output_string != current_version_string
      File.open f.name, "w" do |output|
        p "writing version #{version_string}"
        output.write output_string
      end
    end
  end

  desc "publish compiled version to github"
  task "publish" do |f|
    clean_check = `git status --porcelain`
    unless clean_check.empty?
      abort "uncommitted changes, cannot publish"
    end
    unless system("git describe --exact-match --tags HEAD")
      #create tag if it doesnt exist
      automatic_tag_name = `git describe | tr -d '\n'`
      sh "git tag #{automatic_tag_name}"
    end
    tag_name = `git describe --tags | tr -d '\n'`
    sh "git push"
    sh "git push --tags"
    Rake::Task["ClassicThesis.pdf"].invoke
    token = `cat ~/github_token | tr -d '\n'`
    sh "upload-release.py -vvv --owner luvemil --repo phd-thesis --tag #{tag_name} --token #{token} ClassicThesis.pdf"
  end
end
