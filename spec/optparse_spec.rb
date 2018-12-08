describe Moodwall::Optparse do
  describe "#parse" do
    let!(:parser) { described_class.new }

    context "without flags" do
      subject { parser.parse([]) }

      it { is_expected.to be_kind_of Moodwall::Optparse::ScriptOptions }

      it "should have set -c (change) by default" do
        expect(subject.change).to eq true
      end

      it "should have set -w (wallpaper) by default" do
        expect(subject.change).to eq true
      end
    end

    context "with -h (--help) flag" do
      context "short version" do
        subject { parser.parse(["-h"]) }

        it "should print help to STDOUT" do
          expect { subject }.to output(String).to_stdout
        end
      end

      context "short version" do
        subject { parser.parse(["--help"]) }

        it "should print help to STDOUT" do
          expect { subject }.to output(String).to_stdout
        end
      end
    end

    context "with -v (--version) flag" do
      context "short version" do
        subject { parser.parse(["-v"]) }

        it "should print version" do
          expect { subject }.to output(Moodwall::VERSION).to_stdout
        end
      end
    end

    context "with -c (--change) flag" do
      context "short version" do
        subject { parser.parse(["-c"]) }

        it "should set `change` to true" do
          expect(subject.change).to eq true
        end

        it "should set `add` to false" do
          expect(subject.add).to eq false
        end
      end

      context "long version" do
        subject { parser.parse(["--change"]) }

        it "should set `change` to true" do
          expect(subject.change).to eq true
        end

        it "should set `add` to false" do
          expect(subject.add).to eq false
        end
      end
    end

    context "with -a (--add) flag" do
      context "short version" do
        subject { parser.parse(["-a"]) }

        it "should set `add` to true" do
          expect(subject.add).to eq true
        end

        it "should set `change` to false" do
          expect(subject.change).to eq false
        end
      end

      context "long version" do
        subject { parser.parse(["--add"]) }

        it "should set `add` to true" do
          expect(subject.add).to eq true
        end

        it "should set `change` to false" do
          expect(subject.change).to eq false
        end
      end
    end

    context "with -l (--list) flag" do
      context "short version" do
        subject { parser.parse(["-l"]) }

        it "should set `list` to true" do
          expect(subject.list).to eq true
        end

        it "should set `change` to false" do
          expect(subject.change).to eq false
        end

        it "should set `add` to false" do
          expect(subject.add).to eq false
        end
      end

      context "long version" do
        subject { parser.parse(["--list"]) }

        it "should set `list` to true" do
          expect(subject.list).to eq true
        end

        it "should set `change` to false" do
          expect(subject.change).to eq false
        end

        it "should set `add` to false" do
          expect(subject.add).to eq false
        end
      end
    end

    context "with -w (--wallpaper) flag" do
      context "short version" do
        subject { parser.parse(["-w"]) }

        it "should set `wallpaper` to true" do
          expect(subject.wallpaper).to eq true
        end
      end

      context "long version" do
        subject { parser.parse(["--wallpaper"]) }

        it "should set `wallpaper` to true" do
          expect(subject.wallpaper).to eq true
        end
      end

      context "with path provided" do
        let!(:path) { "test/path" }

        subject { parser.parse(["-w", path]) }

        it "should set `path` variable" do
          expect(subject.path).to eq path
        end
      end
    end

    context "with -m (--mood) flag" do
      context "short version" do
        subject { parser.parse(["-m"]) }

        it "should set `mood` to true" do
          expect(subject.mood).to eq true
        end
      end

      context "long version" do
        subject { parser.parse(["--mood"]) }

        it "should set `mood` to true" do
          expect(subject.mood).to eq true
        end
      end

      context "with mood name provided" do
        let!(:mood_name) { "Winter" }

        subject { parser.parse(["-m", mood_name]) }

        it "should set `mood_name` variable" do
          expect(subject.mood_name).to eq mood_name
        end
      end
    end
  end
end
