<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 5/10/2024
  Time: 3:26 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<div class="container-fluid" style="margin-bottom:10%">

    <div class="row">
        <!-- BEGIN SEARCH RESULT -->
        <div class="col-md-12">
            <div class="grid search">
                <div class="grid-body">
                    <div class="row">
                        <!-- BEGIN FILTERS -->
                        <div class="col-md-2">
                        <%@include file="menu.jsp"%>
                        </div>
                        <!-- END FILTERS -->
                        <!-- BEGIN RESULT -->
                        <div class="col-md-10">
                            <div class="card" id="clinical-path">
                                <div class="card-header">
                                    <h2>FDA's Clinical Path to New Medical Products</h2>
                                </div>
                                <div class="card-body">
                                    <img src="/platform/data/protected/IND_phases.png" alt="" width="100%">
                                </div>
                            </div>
                            <div class="card" id="ind-def">
                                <div class="card-header"><h2>What is IND?</h2></div>
                                <div class="card-body">
                                    <p>An Investigational New Drug Application (IND) is a request from a clinical study sponsor to obtain authorization from the Food and Drug Administration (FDA) to administer an investigational drug or biological product to humans. Such authorization must be secured prior to interstate shipment and administration of any new drug or biological product that is not the subject of an approved New Drug Application or Biologics/Product License Application.</p>

                                    <p>Please refer to the sections below for useful information on the development and submission of INDs.</p>
                                </div>
                            </div>
                            <div class="card" id="ind-types">
                                <div class="card-header"><h2>IND types</h2></div>
                                <div class="card-body">
                                    <ul>
                                        <li><strong>Investigator IND</strong>&nbsp;is submitted by a physician who both initiates and conducts an investigation, and under whose immediate direction the investigational drug is administered or dispensed.  A physician might submit a research IND to propose studying an unapproved drug, or an approved product for a new indication or in a new patient population.</li>
                                        <li><strong>Emergency Use IND</strong>&nbsp; allows the FDA to authorize use of an experimental drug in an emergency situation that does not allow time for submission of an IND in accordance with  21CFR , Sec. 312.23 or Sec. 312.20.  It is also used for patients who do not meet the criteria of an existing study protocol, or if an approved study protocol does not exist.</li>
                                        <li><strong>Treatment IND</strong> is submitted for experimental drugs showing promise in clinical testing for serious or immediately life-threatening conditions while the final clinical work is conducted and the FDA review takes place.</li>
                                    </ul>
                                    </div>
                            </div>
                            <div class="card" id="ind-categories">
                                <div class="card-header"><h2>IND Categories</h2></div>
                                <div class="card-body">
                                    <ul>
                                        <li><strong>Commercial:</strong> A commercial IND is one for which the sponsor (usually a corporate entity) intends to commercialize the product by eventually submitting a marketing application. In this case, the sponsor should select "Commercial IND" on FDA Form 1571 Field 6B.  FDA may also designate an IND as commercial if it is clear that the sponsor intends for the product to be commercialized at a later date.</li>
                                        <li><strong>Research (non-commercial):</strong> A research IND (also called a non-commercial IND) is one for which the sponsor (generally an individual investigator, academic institution or non-profit entity) does not intend to later commercialize the product.  These studies are strictly for research, are usually shorter in duration and may result in publications in peer-reviewed journals.</li>
                                    </ul>
                                  </div>
                            </div>

                            <div class="card" id="ind-meetings">
                                <div class="card-header"><h2>IND FDA MEETINGS</h2></div>
                                <div class="card-body">
                                    <ul>
                                        <li><strong>INTERACT Meeting:</strong> INTERACT or an INitial Targeted Engagement for Regulatory Advice on CBER/CDER ProducTs is a meeting at a specific time early in product development. The appropriate timing for an INTERACT is when a sponsor has identified the investigational product to be evaluated in a clinical study and conducted some preliminary preclinical proof-of-concept studies with the intended investigational product, but has not yet designed and conducted definitive toxicology studies. For additional details on a development program's qualification for INTERACT, how to request and where to send the meeting request, please see <a href="https://www.fda.gov/vaccines-blood-biologics/cellular-gene-therapy-products/otp-interact-meeting" target="_blank"><strong>FDA INTEACT Meeting Guidance</strong></a><br></li>
                                        <li>&nbsp;</li>
                                        <li><strong>Pre IND Meeting:</strong> Pre-IND meetings can be valuable for sponsors in procuring feedback on a sponsor's product development program. A pre-IND meeting can also provide information that will assist sponsors in preparing to submit complete investigational new drug (IND) applications and reduce the risk of a clinical hold. The primary purpose of this meeting is to review and obtain feedback on the design of preclinical studies, the design of the initial IND study, and product manufacturing and quality controls needed to initiate human studies. The meeting also provides an opportunity to discuss the  plans for studying the product in pediatric populations, the target product profile,  the quality target product profile, the design and results of any natural history studies, and the best approach for presentation and formatting of data in the IND.</li>
                                    </ul>
                                </div>
                            </div>
                            <div class="card" id="timing-pre-ind">
                                <div class="card-header"><h2>Timing of Pre-IND Meeting Request</h2></div>
                                <div class="card-body">
                                    Sponsors are sometimes unsure whether to request an INTERACT or pre-IND meeting for the current state of development of their product. See INTERACT Meeting Section for information regarding INTERACT meetings.  In general, a pre-IND is the appropriate meeting type if:
<ul>
                                   <li>The sponsor has defined the manufacturing process to be used for the clinical studies and has developed assays and preliminary lot release criteria.</li>
    <li>The sponsor has completed proof-of-concept (POC) and possibly some preliminary preclinical safety/toxicology studies and desires to move to the definitive toxicology studies</li>
    <li>The sponsor's questions involve IND-enabling Chemistry, Manufacturing, and Controls (CMC), pharmacology/toxicology (P/T), and/or clinical trial design issues.</li>
</ul>
                                    <a target=_blank href="https://www.fda.gov/vaccines-blood-biologics/cellular-gene-therapy-products/otp-pre-ind-meetings"><strong>Process for requesting a pre-IND meeting</strong></a>
                                </div>
                            </div>




                            <div class="card" id="ind-content-format">
                                <div class="card-header"><h2>IND Content and Format&nbsp;<a href="https://www.fda.gov/vaccines-blood-biologics/investigational-new-drug-applications-inds-cber-regulated-products/submission-investigational-new-drug-application-ind-cber" target="_blank" title="Go to FDA"><i class="fa fa-external-link" aria-hidden="true"></i></a></h2></div>
                                <div class="card-body">

                                    <p>The content and format of an IND submission must be complete, well-organized as per 21 CFR 312, and include all applicable FDA Forms, provided below. These forms can also be found in <a data-entity-substitution="canonical" data-entity-type="node" data-entity-uuid="41aa2346-1c33-4025-b0c6-e0db744ee4ab" href="https://www.fda.gov/about-fda/reports-manuals-forms/forms" title="Forms">FDA's Form Database</a>.</p>

                                    <ul><li><a data-entity-substitution="media_download" data-entity-type="media" data-entity-uuid="0e4d9050-7768-4a55-ac65-f4675d6e16a3" href="https://www.fda.gov/media/123543/download?attachment" title="Investigational New Drug Application (IND)" download>Form FDA 1571: Investigational New Drug Application</a>&nbsp;<a href="/platform/forms_public/FDA-1571_Instructions_R14_03-21-2023 (1).pdf" target="_blank" class="btn-primary btn-sm">Instructions to fill</a>

                                        <ul><li>For Individual patient INDs, a licensed physician may use <a data-entity-substitution="media_download" data-entity-type="media" data-entity-uuid="4e9ec72c-e5f4-44a8-ba48-8ce94fb0727c" href="/media/98616/download?attachment" title="Individual Patient Expanded Access Investigational New Drug Application (IND) (PDF)**Note: For best form functionality, Right-click 3926 link and click Save Link As… to save to your desktop and then open the file.">Form FDA 3926: Individual Patient Expanded Access IND</a> in place of the Form FDA 1571</li>
                                        </ul></li>
                                        <li><a data-entity-substitution="media_download" data-entity-type="media" data-entity-uuid="4f49c8ae-094f-4035-8c35-c7186ace757c" href="https://www.fda.gov/media/71816/download?attachment" title="Statement of Investigator (Title 21, Code of Federal Regulations (CFR) Part 312)(PDF) At this time, the attached PDF document may not be fully accessible to readers using assistive technology. In the event you are unable to read and/or complete portions o">Form FDA 1572: Statement of Investigator</a></li>
                                        <li><a data-entity-substitution="media_download" data-entity-type="media" data-entity-uuid="a70832bd-5119-4d67-a379-c97b2218132f" href="https://www.fda.gov/media/70465/download?attachment" title="Certification: Financial Interest and Arrangements of Clinical Investigator (PDF)">Form FDA 3454: Certification: Financial Interests and Arrangements of Clinical Investigators</a></li>
                                        <li><a data-entity-substitution="media_download" data-entity-type="media" data-entity-uuid="ad43538f-1178-45d3-91bf-a4f60a614c56" href="https://www.fda.gov/media/127804/download?attachment" title="Disclosure:  Financial Interests and Arrangements Clinical Investigators">Form FDA 3455: Disclosure: Financial Interests and Arrangements of Clinical Investigators</a></li>
                                        <li><a data-entity-substitution="media_download" data-entity-type="media" data-entity-uuid="7d50fac4-68f6-4ede-913b-4ac5e102b860" href="https://www.fda.gov/media/134964/download?attachment" title="Certification of Compliance, under 42 U.S.C. , 282(j)(5)(B), with Requirements of ClinicalTrials.gov ">Form FDA 3674: Certification of Compliance</a></li>
                                    </ul>
                                    <div class="card">
                                        <div class="card-header"><h2>21 CFR 312 - INVESTIGATIONAL NEW DRUG APPLICATION <a href="https://www.ecfr.gov/current/title-21/part-312" target="_blank" title="Code of Federal Regulations (CFR)"><i class="fa fa-external-link" aria-hidden="true"></i></a></h2></div>

                                        <div class="card-body">
                                    <%@include file="cfr-312.23.jsp"%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card" id="ind-submission">
                                <div class="card-header"><h2>Submission of an IND</h2></div>
                                <div class="card-body">
                                    <p>Sponsors of commercial INDs and all subsequent amendments are required to submit information electronically in the electronic Common Technical Document (eCTD) format. For electronic submission in eCTD, see <a data-entity-substitution="canonical" data-entity-type="node" data-entity-uuid="3e77e5d8-6cf2-46ff-acc2-69d8513b0d35" href="/vaccines-blood-biologics/development-approval-process-cber/regulatory-submissions-electronic-format-cber-regulated-products" title="Regulatory Submissions in Electronic Format for CBER-Regulated Products">Information on Regulatory Submissions in Electronic Format for Biologic Products</a>. IND sponsors should request a submission tracking number (STN) from CBER prior to an eCTD submission. Detailed procedures are outlined in <a data-entity-substitution="media_download" data-entity-type="media" data-entity-uuid="3bab0a9d-a105-4b6f-9501-27b8974894bd" href="/media/93416/download?attachment" title="SOPP 8117: Issuing Tracking Numbers in Advance of Electronic Submissions in eCTD Format">SOPP 8117: Issuing Tracking Numbers in Advance of Electronic Submissions in eCTD Format</a>.</p>

                                    <p>While non-commercial/research IND sponsors are exempt from the requirement for electronic submissions, they are encouraged to submit electronically using the eCTD format. For specific instructions on how to submit eCTD exempt non-commercial/research INDs to CBER, please refer to <a data-entity-substitution="media_download" data-entity-type="media" data-entity-uuid="44a3de02-3ee5-4b62-a5bf-9b6792a15875" href="/media/89820/download?attachment" title="SOPP 8110: Submission of Regulatory Applications -- Exempt from eCTD Requirements"> SOPP 8110: Submission of Regulatory Applications- Exempt from eCTD Requirements</a>. General questions regarding the submission of an IND to CBER may be directed to <a href="mailto:industry.biologics@fda.hhs.gov">industry.biologics@fda.gov</a>.</p>

                                </div>
                            </div>
                            <div class="card" id="fda-review-time">
                                <div class="card-header"><h2>Review Time for initial submission</h2></div>
                                <div class="card-body">
                                    <p>Review Time for initial submission of an Investigational New Drug application is 30 days from the date FDA receives the IND. An IND applicant may proceed with a clinical investigation once the applicant has been notified by FDA that the investigation may proceed or after 30 days if the IND is not placed on Clinical Hold.</p>
                                    <img src="/platform/data/protected/review_process.png" alt="">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>