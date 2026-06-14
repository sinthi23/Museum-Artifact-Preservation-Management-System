Namespace MuseumArtifactPreservation

    Partial Public Class [Default]
        Inherits Page

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
            If Not IsPostBack Then
                lblUserRole.Text = "Curator Console"
            End If
        End Sub

        Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As EventArgs)

        End Sub
    End Class

End Namespace