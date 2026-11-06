# AI Study Planner

A local-first Java desktop learning coach built with Swing and JDK classes only. Local rule-based coaching needs no cloud service. Optional OpenAI analysis is available after explicit opt-in and API-key setup. The applet-style `StudyApplet` is a Swing `JPanel` hosted in a normal desktop window because current browsers do not support Java applets.

## Requirements and launch

Install JDK 17 or newer and make `java` and `javac` available. Verify with:

```cmd
java -version
javac -version
```

On Windows, open Command Prompt in this folder and run:

```cmd
run.bat
```

Manual Windows build and launch:

```cmd
mkdir out
dir /s /b src\*.java > sources.txt
javac -encoding UTF-8 -d out @sources.txt
java -cp out aistudyplanner.Main
```

On Linux/macOS:

```sh
mkdir -p out
find src -name '*.java' > sources.txt
javac -encoding UTF-8 -d out @sources.txt
java -cp out aistudyplanner.Main
```

`run.bat` compiles all Java sources and opens the desktop UI. The generated `out/` and `sources.txt` are build artifacts.

## Learning coach features

- **Adaptive Brain:** per-topic mastery (0–100), confidence, last study date, estimated retention/forgetting, and SM-2 review intervals. Missed answers bring reviews forward; successful recall spaces them out. A quiz-completion message explains the schedule change. Generated study blocks rebalance while manual and completed tasks remain.
- **AI Mentor:** floating non-blocking chat with locally saved history and a typing indicator. Local keyword rules answer questions about mastery, the next task, weekly workload, and progress. Online generation is optional and disabled by default.
- **Daily check-in:** energy, mood, and available time. Low-energy days shorten suggested focus blocks and fit generated work to the day. The app flags possible burnout patterns from recorded skipped-plan days, quiz-score declines, long sessions, or a low/stressed check-in; these are suggestions, not diagnoses.
- **Gamification:** XP and levels for real quiz participation, Java2D badge medals, a level-up animation, study streaks, and a five-question challenge from your weakest tracked topics.
- **Smarter testing:** timed mock test with question navigation, answered/skipped/review markers and +4/−1 scoring; detailed results with elapsed time; quiz attempt history; mistake notebook; and spaced-repetition flashcards.
- **Reliable quiz timeout saving:** when a question timer ends, the selected option is recorded automatically; if nothing was selected, the response is saved as skipped. Each answer is written to the local data file immediately, and the result screen reports how many timed-out responses were saved.
- **Goals:** set an exam date and target score. Readiness and the what-if slider use topic mastery, or subject strength before quiz data exists. The score projection is a simple planning estimate, not a calibrated exam prediction.
- **Weekly Insights:** focused versus uncompleted planned minutes, best recorded start hour, most improved topic, lowest mastery, three suggested actions, text export, and a 12-week Java2D activity heatmap. Time-of-day insights become useful after sessions have been recorded with start times.
- **Polish:** three-step onboarding wizard, animated Java2D splash, button tooltips, Ctrl+N new task, Ctrl+Q quiz, custom accent color, light/dark themes, and a configurable Study-Wise logo.
- **Study-Wise interface:** a white navigation rail, soft lavender-gray workspace, roomy white cards, teal actions, a daily greeting, task checklist, progress card, streak panel, and AI study tip. The study illustration is drawn with Java2D; no external images or libraries are required.
- **Modern typography and controls:** a single Segoe UI / Inter / Poppins / Arial family selected from installed fonts, bold title hierarchy, rounded cards and buttons, and hover feedback.
- **Student navigation:** Dashboard, Study Planner, Upload Material, AI Mentor, Quiz Center, Progress & Weak Areas, Revision Notes, Current Affairs / Daily Practice, Settings, Weekly Insights, Goals & Readiness, and Subjects. Settings include font size and UPSC/TNPSC exam focus.
- **Material analysis:** upload PDF/DOCX/PPTX/TXT/Markdown/HTML, paste text, or analyze an HTTP/HTTPS page. DOCX/PPTX use built-in ZIP/XML parsing; PDF text extraction is best-effort for text-based files. Image OCR uses local Tesseract if installed; images are not uploaded for OCR. Local summaries and material-grounded Q&A work without an API key.
- **Material quizzes:** generate four-option questions from loaded material with a selectable question count, difficulty, and topic focus. Generated questions join the saved quiz bank and flashcards. Quiz and mock-test results preserve answer review, accuracy, and elapsed time.
- **Optional OpenAI mentor:** an opt-in setting enables generated analysis and chat. It sends extracted chat/material text to the OpenAI Responses API only when enabled and `OPENAI_API_KEY` exists. Keep the key in Windows user environment variables, never source or a committed project file. `OPENAI_MODEL` optionally selects a model; the current default is `gpt-4.1-mini`. API use requires Internet and may incur OpenAI charges.
- **Theme migration:** existing installations using the original purple/dark defaults migrate to the new light teal appearance once. Dark mode remains available from the navigation rail.

The project also retains subject/topic management, generated schedules, tasks, local material-to-quiz creation for `.txt`/Markdown files, standard quizzes, dashboard, progress charts, quote favorites, reflections, CSV export, and backup/restore.

## App logo

To show your logo beside the Study-Wise title and as the desktop window/taskbar icon, place a PNG image at `resources/images/study-wise-logo.png` in the project folder. The sidebar image is fitted to 36 pixels high without changing its aspect ratio. If the file is missing or cannot be read, the app continues with the title only and logs the reason to the console. To use another path or file name, edit the single `LOGO_PATH` constant in `src/aistudyplanner/ui/AppBranding.java`.

## Adaptive-learning self-checks

After building, run the dependency-free checks:

```cmd
java -cp out aistudyplanner.SelfCheck
```

They check SM-2 intervals and reset behavior, mastery movement after correct/wrong answers, and insertion of due revision tasks into the schedule.

## Data and privacy

The app saves under `data/` relative to its launch folder:

- `data/planner.dat` — profile, topics, tasks, study sessions, quiz attempts, mastery, XP, badges, flashcards, and notes.
- `data/planner.dat.bak` — previous save before a new save.
- `data/questions.csv` — editable quiz bank plus approved questions generated from local study material.

Uploaded source files are read locally and are not copied into the project. Extracted text and its study brief are saved in the local planner data. They stay on this computer unless the optional online AI setting is enabled; generated questions are stored in the quiz CSV. Existing data from earlier versions is loaded with defaults for newly added fields.

## Notes about the estimates

SM-2 uses its ease-factor and interval progression. Topic quiz accuracy is aggregated once per topic per quiz, mapped to an SM-2 quality score from 0–5. Mastery and confidence are local heuristics, not scientific measures of knowledge. The mentor uses local rules unless online AI is explicitly enabled. The what-if score change uses a deliberately bounded scenario formula. Edit `KnowledgeModel`, `RuleBasedMentor`, or the goal screen to tune these assumptions.

## Material analysis and optional online AI

The Upload Material page accepts PDF, DOCX, PPTX, TXT, Markdown, HTML, pasted text, and HTTP/HTTPS web pages. DOCX/PPTX use the JDK ZIP/XML APIs. PDF text extraction is best-effort and works only on text-based PDFs. Image OCR uses local Tesseract if installed; Study-Wise does not upload images for OCR.

Local study briefs and material-grounded passage matching need no API key. To enable generated OpenAI analysis and chat, set `OPENAI_API_KEY` as a Windows user environment variable before launching the app, then enable “Online AI & privacy” in Settings. With that option on, extracted chat/material text can be sent to OpenAI. Keep the key out of source files. `OPENAI_MODEL` optionally selects a model; this version defaults to `gpt-4.1-mini`. Internet access and OpenAI API charges may apply.

