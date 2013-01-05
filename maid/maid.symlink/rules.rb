# Sample Maid rules file -- some ideas to get you started.
#
# To use, remove ".sample" from the filename, and modify as desired.  Test using:
#
#     maid clean -n
#
# **NOTE:** It's recommended you just use this as a template; if you run these rules on your machine without knowing what they do, you might run into unwanted results!
#
# Don't forget, it's just Ruby!  You can define custom methods and use them below:
#
#     def magic(*)
#       # ...
#     end
#
# If you come up with some cool tools of your own, please send me a pull request on GitHub!
#
# For more help on Maid:
#
# * Run `maid help`
# * Read the README, tutorial, and documentation at https://github.com/benjaminoakes/maid#maid
# * Ask me a question over email (hello@benjaminoakes.com) or Twitter (@benjaminoakes)

Maid.rules do

  # My own rules

  # Group : Downloads

  rule 'Remove duplicates' do
    trash(dir('~/Downloads/* (1).*'))
    trash(dir('~/Downloads/* (2).*'))
    trash(dir('~/Downloads/*.1'))
  end

  # rule 'Mac OS X applications in disk images' do
  #   dir('~/Downloads/*.dmg').each do |path|
  #     if 3.days.since? accessed_at(path)
  #       trash(path)
  #     end
  #   end
  # end

  # rule 'Mac OS X applications in zip files' do
  #   found = dir('~/Downloads/*.zip').select { |path|
  #     3.days.since?(accessed_at(path)) and zipfile_contents(path).any? { |c| c.match(/\.app$/) }
  #   }

  #   trash(found)
  # end

  # NOTE: Currently, only Mac OS X supports `downloaded_from`.
  rule 'Old files downloaded while developing/testing' do
    dir('~/Downloads/*').each do |path|
      if downloaded_from(path).any? { |u| u.match('http://localhost') } && 1.week.since?(accessed_at(path))
        trash(path)
      end
    end
  end

  rule 'Move .pdf to my dropbox after 10 minutes' do
    dir('~/Downloads/*.pdf').each do |path|
      if 10.minutes.since? accessed_at(path)
        move path, '~/Dropbox/PDFs'
      end
    end
  end

  rule 'Move .torrent after 1 hour' do
    dir('~/Downloads/*.torrent').each do |path|
      if 1.hour.since? accessed_at(path)
        move path, '~/Downloads/Torrents'
      end
    end
  end

  rule 'Organize files after 1 hour' do
    # Archives
    mkdir '~/Downloads/Archives'
    dir('~/Downloads/*.{zip,tgz,gz,rar,tar,7z}').each do |path|
      if 1.hour.since? accessed_at path
        move path, '~/Downloads/Archives'
      end
    end

    # Images
    mkdir '~/Downloads/Images'
    dir('~/Downloads/*.{png,gif,jpeg,jpg}').each do |path|
      if 1.hour.since? accessed_at path
        move path, '~/Downloads/Images'
      end
    end

    # Disk images
    mkdir '~/Downloads/DMG'
    dir('~/Downloads/*.{dmg,iso}').each do |path|
      if 1.hour.since? accessed_at path
        move path, '~/Downloads/DMG'
      end
    end
  end

  rule 'Move old files (non-folder) after 1 week' do
    mkdir '~/Downloads/Old Files'
    dir('~/Downloads/*.*').each do |path|
      if 1.week.since? accessed_at path
        move path, '~/Downloads/Old Files'
      end
    end
  end

  # Set newly added files label to blue if added in the last 1 day (todo)
  # Remove blue label after 1 day passed (todo)

  # Group : Dropbox
  rule 'Move .pdf' do
    dir('~/Dropbox/*.pdf').each do |path|
      move path, '~/Dropbox/PDFs'
    end
  end

  rule 'Move files into [Inbox] after 1 day' do
    dir('~/Dropbox/*.*').each do |path|
      if 1.day.since? created_at(path) and !path.match(/1Password/)
        move path, '~/Dropbox/[Inbox]'
      end
    end
  end

  # Group Desktop
  rule 'Move screenshots into captures folder and rename' do
    dir('~/Desktop/Screen Shot *').each do |path|
      file_created_at = created_at(path).strftime "%Y%m%d-%H%M%S"
      move(path, "~/Dropbox/Captures/#{file_created_at}#{File.extname(path)}")
    end
  end

  # Group Captures
  rule 'Rename' do
    dir('~/Dropbox/Captures/Screen Shot *').each do |path|
      file_created_at = created_at(path).strftime "%Y%m%d-%H%M%S"
      move(path, "~/Dropbox/Captures/#{file_created_at}#{File.extname(path)}")
    end
  end

  # Group Applications
  # Label unused apps (1 month) (todo)
end
