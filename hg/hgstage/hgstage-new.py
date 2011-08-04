from mercurial import ui, hg, patch

def

def hgstage(ui, repo):
    print "hg stage is yet to be implemented!"

cmdtable = {
    "stage": (hgstage,
        "hg stage [paths]"
    )
}
