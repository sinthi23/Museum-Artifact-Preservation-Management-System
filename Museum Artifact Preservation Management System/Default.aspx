<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Museum_Artifact_Preservation_Management_System.Default" %>

<!DOCTYPE html>
<html lang="en">
  <head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Museum Artifact Preservation Management System</title>
    <link href="Content/Site.css" rel="stylesheet" />
  </head>
  <body>
    <form id="form1" runat="server">
      <main class="shell">
        <header class="topbar">
          <div class="brand-block">
            <p class="eyebrow">Curatorial Operations</p>
            <h1>Museum Artifact Preservation Management System</h1>
            <p class="hero-copy">
              A refined workspace for artifact records, conservation planning,
              and loan oversight.
            </p>
          </div>
          <asp:Label ID="lblUserRole" runat="server" CssClass="role-badge" />
        </header>

        <section class="feature-intro">
          <article class="feature-card feature-card--primary">
            <div class="feature-card__header">
              <div>
                <p class="feature-kicker">01 · Core Records</p>
                <h2>Artifact Management</h2>
                <p>
                  Store complete artifact profiles, classify them by category,
                  and keep provenance, material, and image details organized in
                  one clean workspace.
                </p>
              </div>
              <span class="feature-chip">Cataloging</span>
            </div>

            <div class="feature-metrics">
              <div>
                <strong>Identity</strong>
                <span>Name, origin, era, and material</span>
              </div>
              <div>
                <strong>Classification</strong>
                <span>Category and historical period</span>
              </div>
              <div>
                <strong>Media</strong>
                <span>Images and reference attachments</span>
              </div>
            </div>

            <ul class="feature-list">
              <li>Organize artifact records by collection standards.</li>
              <li>Keep provenance and description data easy to search.</li>
              <li>Present a clean overview for curators and staff.</li>
            </ul>
          </article>

          <article class="feature-card feature-card--secondary">
            <div class="feature-card__header">
              <div>
                <p class="feature-kicker">02 · Preservation Watch</p>
                <h2>Condition &amp; Damage Tracking</h2>
                <p>
                  Monitor current condition, log damage reports, and keep a
                  visible restoration history so urgent items stand out fast.
                </p>
              </div>
              <span class="feature-chip feature-chip--alt">Monitoring</span>
            </div>

            <div class="feature-metrics">
              <div>
                <strong>Condition</strong>
                <span>Excellent, stable, damaged, or critical</span>
              </div>
              <div>
                <strong>Damage Logs</strong>
                <span>Open issues and incident notes</span>
              </div>
              <div>
                <strong>Restoration</strong>
                <span>Conservation history and follow-up</span>
              </div>
            </div>

            <ul class="feature-list">
              <li>Highlight artifacts needing immediate attention.</li>
              <li>Track restoration progress with dates and notes.</li>
              <li>Support better planning for conservation staff.</li>
            </ul>
          </article>
        </section>

        <section class="search-panel">
          <div class="search-heading">
            <div>
              <h2>Artifact Search</h2>
              <p>
                Search artifacts by era, origin, material, category, condition,
                location, value, loans, or restoration status.
              </p>
            </div>
            <asp:Button
              ID="btnAddArtifact"
              runat="server"
              Text="+ Add Artifact"
              CssClass="primary-button"
            />
          </div>

          <div class="keyword-row">
            <asp:TextBox
              ID="txtKeyword"
              runat="server"
              CssClass="keyword-input"
              placeholder="Search by artifact name, description, provenance..."
            />
            <asp:Button
              ID="btnSearch"
              runat="server"
              Text="Search"
              CssClass="search-button"
              OnClick="btnSearch_Click"
            />
          </div>

          <div class="filter-grid">
            <label>
              Era / Period
              <asp:DropDownList ID="ddlEra" runat="server" CssClass="field">
                <asp:ListItem Text="Any Era" Value="" />
                <asp:ListItem Text="Ancient" Value="Ancient" />
                <asp:ListItem Text="Medieval" Value="Medieval" />
                <asp:ListItem Text="Renaissance" Value="Renaissance" />
                <asp:ListItem Text="Modern" Value="Modern" />
              </asp:DropDownList>
            </label>

            <label>
              Origin Country
              <asp:DropDownList ID="ddlOrigin" runat="server" CssClass="field">
                <asp:ListItem Text="Any Origin" Value="" />
                <asp:ListItem Text="Egypt" Value="Egypt" />
                <asp:ListItem Text="Greece" Value="Greece" />
                <asp:ListItem Text="Bangladesh" Value="Bangladesh" />
                <asp:ListItem Text="Italy" Value="Italy" />
              </asp:DropDownList>
            </label>

            <label>
              Category
              <asp:DropDownList
                ID="ddlCategory"
                runat="server"
                CssClass="field"
              >
                <asp:ListItem Text="Any Category" Value="" />
                <asp:ListItem Text="Sculpture" Value="Sculpture" />
                <asp:ListItem Text="Manuscript" Value="Manuscript" />
                <asp:ListItem Text="Jewelry" Value="Jewelry" />
                <asp:ListItem Text="Weapon" Value="Weapon" />
              </asp:DropDownList>
            </label>

            <label>
              Condition
              <asp:DropDownList
                ID="ddlCondition"
                runat="server"
                CssClass="field"
              >
                <asp:ListItem Text="Any Condition" Value="" />
                <asp:ListItem Text="Excellent" Value="Excellent" />
                <asp:ListItem Text="Stable" Value="Stable" />
                <asp:ListItem Text="Damaged" Value="Damaged" />
                <asp:ListItem
                  Text="Restoration Needed"
                  Value="Restoration Needed"
                />
              </asp:DropDownList>
            </label>
          </div>

          <div class="quick-filters">
            <asp:CheckBox
              ID="chkRestorationNeeded"
              runat="server"
              Text="Restoration needed"
            />
            <asp:CheckBox
              ID="chkOverdueLoans"
              runat="server"
              Text="Overdue loans"
            />
            <asp:CheckBox
              ID="chkHighValue"
              runat="server"
              Text="High-value artifacts"
            />
          </div>
        </section>

        <section class="summary-grid">
          <article>
            <span>Artifacts</span>
            <asp:Label
              ID="lblTotalArtifacts"
              runat="server"
              CssClass="stat-number"
            />
          </article>
          <article>
            <span>Restoration Due</span>
            <asp:Label
              ID="lblRestorationDue"
              runat="server"
              CssClass="stat-number"
            />
          </article>
          <article>
            <span>Active Loans</span>
            <asp:Label
              ID="lblActiveLoans"
              runat="server"
              CssClass="stat-number"
            />
          </article>
        </section>
      </main>
    </form>
  </body>
</html>