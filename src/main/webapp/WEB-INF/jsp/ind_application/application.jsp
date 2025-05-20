<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 5/20/2025
  Time: 11:33 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container">
    <h2>Investigational New Drug (IND) Application</h2>
    <form action="">
    <div class="card">
        <div class="card-header">Sponsor Information</div>
        <div class="card-body">

            <label>Sponsor Name:
                <input class="form-control form-control-sm" type="text" name="sponsor_name" required>
            </label>


            <label>Contact Person:
                <input class="form-control form-control-sm" type="text" name="contact_person" required>
            </label>


            <label>Email:
                <input class="form-control form-control-sm" type="email" name="email" required>
            </label>


            <label>Phone Number:
                <input class="form-control form-control-sm" type="tel" name="phone" required>
            </label>

</div>
</div>
    <div class="card">
        <div class="card-header">Drug Information</div>
        <div class="card-body">
            <label for="drug_name">Investigational Drug Name:
            <input class="form-control form-control-sm" type="text" name="drug_name" id="drug_name" required>
            </label>
            <label for="dosage_form">Dosage Form:
            <input class="form-control form-control-sm" type="text" name="dosage_form" id="dosage_form">
            </label>
            <label>Route of Administration:
            <input class="form-control form-control-sm" type="text" name="route_admin">
            </label>
            <label>Therapeutic Area:
            <input class="form-control form-control-sm" type="text" name="therapeutic_area"></label>

        </div>
    </div>
    <div class="card">
        <div class="card-header">Clinical Trial Information</div>
        <div class="card-body">
            <label>Study Title:
            <input class="form-control form-control-sm" type="text" name="study_title" required>
            </label>
            <label>Study Phase:
            <select class="form-control form-control-sm" name="study_phase">
                <option value="1">Phase 1</option>
                <option value="2">Phase 2</option>
                <option value="3">Phase 3</option>
                <option value="4">Phase 4</option>
            </select>
            </label>
            <label for="ind_number">IND Number (if known):
            <input class="form-control form-control-sm" type="text" name="ind_number" id="ind_number"></label>

        </div>
    </div>
    <div class="card">
        <div class="card-header">Submission Details</div>
        <div class="card-body">
            <label>Submission Date:
            <input class="form-control form-control-sm"  type="date" name="submission_date">
            </label>
            <label>Submission Type:
            <select class="form-control form-control-sm" name="submission_type">
                <option value="initial">Initial IND</option>
                <option value="amendment">Amendment</option>
                <option value="annual_report">Annual Report</option>
            </select>
            </label>
            <label>Documents Uploaded:
            <input class="form-control form-control-sm" type="file" name="documents" multiple>
            </label>
        </div>
    </div>
    <div class="card">
        <div class="card-header">Drug Safety Information</div>
        <div class="card-body">
            <label>Known Adverse Effects:</label>
            <textarea class="form-control form-control-sm" name="adverse_effects" rows="4"></textarea>

            <label>Preclinical Data Summary:</label>
            <textarea class="form-control form-control-sm" name="preclinical_data" rows="4"></textarea>

        </div>
    </div>
    <div class="card">
        <div class="card-header">IRB Information</div>
        <div class="card-body">
            <label>IRB Approval Number:
            <input class="form-control form-control-sm" type="text" name="irb_approval">
            </label>
            <label>IRB Approval Date:
            <input class="form-control form-control-sm" type="date" name="irb_approval_date">
            </label>
        </div>
    </div>
    <button type="submit">Submit Application</button>
    <button type="reset">Reset</button>
    </form>
</div>