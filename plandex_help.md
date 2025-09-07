Usage
  plandex [command] [flags]
  pdx [command] [flags]

 Help
  plandex help # show basic usage
  plandex help --all # show all commands
  plandex [command] --help

 Getting Started

 🚀 Start the Plandex REPL in a project directory with  plandex  or  pdx

 💻 You can also use any command outside the REPL with  plandex [command]  or  pdx [command]

 REPL Options

  Mode
    --chat, -c     Start in chat mode (for conversation without making changes)
    --tell, -t     Start in tell mode (for implementation)

  Autonomy
    --no-auto      None → step-by-step, no automation
    --basic        Basic → auto-continue plans
    --plus         Plus → auto-update context, smart context, auto-commit changes
    --semi         Semi-Auto → auto-load context
    --full         Full-Auto → auto-apply, auto-exec, auto-debug

  Models
    --daily        Daily driver pack
    --reasoning    Reasoning pack
    --strong       Strong pack
    --cheap        Cheap pack
    --oss          Open source pack

 Key Commands
  plandex new  👉 start a new plan
  plandex (l)oad  👉 load files/dirs/urls/notes/images or pipe data into context
  plandex (t)ell  👉 describe a task to complete
  plandex diff  👉 review pending changes in 'git diff' format
  plandex diff --ui  👉 review pending changes in a browser UI
  plandex (ap)ply  👉 apply pending changes to project files
  plandex reject (rj)  👉 reject pending changes to one or more project files
  plandex debug (db)  👉 repeatedly run a command and auto-apply fixes until it succeeds
  plandex (ch)at  👉 ask a question or chat

 Plans
  plandex new  👉 start a new plan
  plandex (pl)ans  👉 list plans
  plandex cd  👉 set current plan by name or index
  plandex (cu)rrent  👉 show current plan
  plandex delete-plan (dp)  👉 delete plan by name or index
  plandex rename  👉 rename the current plan
  plandex (arc)hive  👉 archive a plan
  plandex plans --archived  👉 list archived plans
  plandex (unarc)hive  👉 unarchive a plan

 Changes
  plandex diff  👉 review pending changes in 'git diff' format
  plandex diff --ui  👉 review pending changes in a browser UI
  plandex diff --plain  👉 review pending changes in 'git diff' format with no color formatting
  plandex (ap)ply  👉 apply pending changes to project files
  plandex reject (rj)  👉 reject pending changes to one or more project files

 Context
  plandex (l)oad  👉 load files/dirs/urls/notes/images or pipe data into context
  plandex ls  👉 list everything in context
  plandex rm  👉 remove context by index, range, name, or glob
  plandex (u)pdate  👉 update outdated context
  plandex clear  👉 remove all context

 Branches
  plandex (br)anches  👉 list plan branches
  plandex checkout (co)  👉 checkout or create a branch
  plandex delete-branch (dlb)  👉 delete a branch by name or index

 History
  plandex log  👉 show log of plan updates
  plandex rewind (rw)  👉 rewind to a previous state
  plandex convo  👉 show plan conversation
  plandex convo 1  👉 show a specific message in the conversation
  plandex convo 2-5  👉 show a range of messages in the conversation
  plandex convo --plain  👉 show conversation in plain text
  plandex summary  👉 show the latest summary of the current plan

 Control
  plandex (t)ell  👉 describe a task to complete
  plandex (c)ontinue  👉 continue the plan
  plandex (b)uild  👉 build any pending changes
  plandex debug (db)  👉 repeatedly run a command and auto-apply fixes until it succeeds
  plandex (ch)at  👉 ask a question or chat

 Streams
  plandex ps  👉 list active and recently finished plan streams
  plandex (conn)ect  👉 connect to an active plan stream
  plandex stop  👉 stop an active plan stream

 Config
  plandex config  👉 show current plan config
  plandex set-config  👉 update current plan config
  plandex config default  👉 show the default config for new plans
  plandex set-config default  👉 update the default config for new plans

 Autonomy
  plandex set-auto  👉 update auto-mode (autonomy level) for current plan
  plandex set-auto default  👉 set the default auto-mode for new plans
  plandex set-auto full  👉 set auto-mode to 'full'
  plandex set-auto semi  👉 set auto-mode to 'semi'
  plandex set-auto plus  👉 set auto-mode to 'plus'
  plandex set-auto basic  👉 set auto-mode to 'basic'
  plandex set-auto none  👉 set auto-mode to 'none'

 AI Models
  plandex models  👉 show current plan model settings
  plandex models default  👉 show the default model settings for new plans
  plandex model-packs  👉 show all available model packs
  plandex set-model  👉 update current plan model settings
  plandex set-model daily  👉 Use 'daily-driver' model pack
  plandex set-model reasoning  👉 Use 'reasoning' model pack
  plandex set-model strong  👉 Use 'strong' model pack
  plandex set-model cheap  👉 Use 'cheap' model pack
  plandex set-model oss  👉 Use 'oss' model pack
  plandex set-model default  👉 update the default model settings for new plans

 Custom Models
  plandex models custom  👉 manage custom models, providers, and model packs
  plandex models available  👉 show all available models
  plandex models available --custom  👉 show available custom models only
  plandex providers  👉 show all available model providers
  plandex providers --custom  👉 show available custom model providers only
  plandex model-packs  👉 show all available model packs
  plandex model-packs --custom  👉 show custom model packs only
  plandex model-packs show  👉 show a built-in or custom model pack's settings

 Accounts
  plandex sign-in  👉 sign in, accept an invite, or create an account
  plandex invite  👉 invite a user to join your org
  plandex revoke  👉 revoke an invite or remove a user from your org
  plandex users  👉 list users and pending invites in your org

 Integrations
  plandex connect-claude  👉 connect your Claude Pro or Max subscription
  plandex disconnect-claude  👉 disconnect your Claude Pro or Max subscription
  plandex claude-status  👉 status of your Claude Pro or Max subscription connection

 Cloud
  plandex usage  👉 show Plandex Cloud current balance and usage report
  plandex usage --today  👉 show Plandex Cloud usage for the day so far
  plandex usage --month  👉 show Plandex Cloud usage for the current billing month
  plandex usage --plan  👉 show Plandex Cloud usage for the current plan
  plandex usage --log  👉 show Plandex Cloud transaction log
  plandex billing  👉 show Plandex Cloud billing settings

 New Plan Shortcuts
  plandex new --full  👉 start a new plan with auto-mode 'full'
  plandex new --semi  👉 start a new plan with auto-mode 'semi'
  plandex new --plus  👉 start a new plan with auto-mode 'plus'
  plandex new --basic  👉 start a new plan with auto-mode 'basic'
  plandex new --none  👉 start a new plan with auto-mode 'none'
  plandex new --daily  👉 start a new plan with 'daily-driver' model pack
  plandex new --reasoning  👉 start a new plan with 'reasoning' model pack
  plandex new --strong  👉 start a new plan with 'strong' model pack
  plandex new --cheap  👉 start a new plan with 'cheap' model pack
  plandex new --oss  👉 start a new plan with 'oss' model pack
  plandex new --gemini-planner  👉 start a new plan with 'gemini-planner' model pack
  plandex new --o3-planner  👉 start a new plan with 'o3-planner' model pack
  plandex new --r1-planner  👉 start a new plan with 'r1-planner' model pack
  plandex new --perplexity-planner  👉 start a new plan with 'perplexity-planner' model pack
  plandex new --opus-planner  👉 start a new plan with 'opus-planner' model pack
