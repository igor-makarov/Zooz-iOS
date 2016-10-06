# Zooz Apple iOS SDK – version 1.2
This version now supports bitcode.

## Installing the Zooz iOS SDK Framework
1.	Download the **Source code zip (Zooz-iOS zip)** and the **Zooz-iOS-Frameworks.zip** files from https://github.com/Zooz/Zooz-iOS/releases  
2.	Unzip the **Zooz-iOS zip** file into any location on your drive.
3.	Drag the **Zooz.framework** into your Xcode project hierarchy.
4.	Select your project in "**Add to targets**", and select "**Copy..**" in the **Destination******.  
    **Note:** *Make sure to click "Copy", when adding the framework to your project. 
If "Copy" is not clicked, and then the downloaded SDK is moved, the app build may not work.*
    ![](../blob/docs/images/Zooz_Apple_iOS_SDK_version_2.png)
5.  Add the framework to the Embedded Binaries of the target.
    ![](../blob/docs/images/Zooz_Apple_iOS_SDK_version_3.png)
6.  Add the following framework headers into the “Zooz-iOS” reference file.
<table>
<colgroup>
<col width="100%" />
</colgroup>
<thead>
<tr class="header">
<th><p>#import &lt;Zooz/ZoozController.h&gt;</p>
<p>#import &lt;Zooz/ZoozAddPaymentMethodRequest.h&gt;</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>

## Coding
1.  Create the Zooz Controller object:
<table>
<colgroup>
<col width="100%" />
</colgroup>
<thead>
<tr class="header">
<th><p>ZoozController *zooz = [[ZoozController alloc] initWithProgramId:programId.text zoozServerURL:serverUrl.text delegate:self];</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>

2.  Create the "ZoozPaymentMethodDetails" to hold the card details taken from your UI.
<table>
<colgroup>
<col width="100%" />
</colgroup>
<thead>
<tr class="header">
<th><p>ZoozPaymentMethodDetails *card = [[ZoozPaymentMethodDetails alloc] init];</p>
<p>    card.cardNumber = cardNumber.text;</p>
<p>    card.cvvNumber = cvv.text;</p>
<p>    card.expirationMonth = month.text;</p>
<p>    card.expirationYear = year.text;</p>
<p>    card.cardHolderName = cardHolderName.text;</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>
3.  Create either an "add card" or a "remove card" request:
<table>
<colgroup>
<col width="100%" />
</colgroup>
<thead>
<tr class="header">
<th><p>ZoozAddPaymentMethodRequest *addRequest = [ZoozAddPaymentMethodRequest createRequestWithPaymentToken:paymentToken.text emailAddress:email.text address:nil paymentMethodDetails: card isRememberPaymentMethod:rememberMe.on];</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>
4.  Execute the request:
<table>
<colgroup>
<col width="100%" />
</colgroup>
<thead>
<tr class="header">
<th><p>[zooz executeZoozRequest:addRequest]</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>
5.  Implement the delegate methods to receive the success or failure callbacks of adding the card.
Note: *The delegate methods are requested in a background thread, not on the main UI thread.*

## ControllerConfiguration Class Definition
<table>
<colgroup>
<col width="33%" />
<col width="33%" />
<col width="33%" />
</colgroup>
<thead>
<tr class="header">
<th><p>Attribute Name</p></th>
<th><p>Description</p></th>
<th><p>Mandatory</p></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>zoozServer</p></td>
<td><p>The Zooz server URL.</p></td>
<td><p>Yes</p></td>
</tr>
<tr class="even">
<td><p>programId</p></td>
<td><p>Program ID as registered in the Zooz Portal.</p></td>
<td><p>Yes</p></td>
</tr>
<tr class="odd">
<td><p>paymentToken</p></td>
<td><p>A paymentToken is a secure token representing a payment in the Zooz system. You can generate this value any of the following ways:</p>
<ul>
<li>The paymentToken attribute from the openPayment request.</li>
<li>The customerToken attribute from the getToken request.</li>
</ul></td>
<td><p>Yes</p></td>
</tr>
</tbody>
</table>

## addPaymentMethod request
<table> 
<thead> 
<tr> 
<th colspan="2"> 
<p class="TableHeadingSmall1">Attribute Name</p> 
</th> 
<th> 
<p class="TableHeadingSmall1">Description</p> 
</th> 
<th> 
<p class="TableHeadingSmall1">Mandatory</p> 
</th> 
</tr> 
</thead> 
<tbody> 
<tr> 
<td colspan="2"> 
<p class="TableTextSmall1">paymentToken</p> 
</td> 
<td> 
<p class="TableTextSmall1">A paymentToken is a secure token representing a payment in the Zooz system. You can generate this value any of the following ways:</p> 
<ul style="list-style-type: disc;margin-left: 19pt;"> 
<li style="list-style-type: disc;">The paymentToken attribute from the openPayment request.</li> 
<li style="list-style-type: disc;">The customerToken attribute from the getToken request.</li> 
</ul> 
</td> 
<td> 
<p class="TableTextSmall1">Yes</p> 
</td> 
</tr> 
<tr> 
<td colspan="2"> 
<p class="TableTextSmall1">email</p> 
</td> 
<td> 
<p class="TableTextSmall1">Card holder email address.</p> 
</td> 
<td> 
<p class="TableTextSmall1">Yes</p> 
</td> 
</tr> 
<tr> 
<td colspan="2"> 
<p class="TableTextSmall1">billingAddress</p> 
</td> 
<td> 
<p class="TableTextSmall1">User billing address.</p> 
</td> 
<td> 
<p class="TableTextSmall1">No</p> 
</td> 
</tr> 
<tr> 
<td colspan="2"> 
<p class="TableTextSmall1">rememberPaymentMethod</p> 
</td> 
<td> 
<p class="TableTextSmall1">To save the payment method for future transactions. Default value is true.</p> 
</td> 
<td> 
<p class="TableTextSmall1">Yes</p> 
</td> 
</tr> 
<tr> 
<td rowspan="5"> 
<p class="TableTextSmall1">paymentMethodDetails</p> 
</td> 
<td> 
<p class="TableTextSmall1">cardHolderName</p> 
</td> 
<td> 
<p class="TableTextSmall1">Name on credit card.</p> 
</td> 
<td> 
<p class="TableTextSmall1">Yes</p> 
</td> 
</tr> 
<tr> 
<td> 
<p class="TableTextSmall1">expirationDate</p> 
</td> 
<td> 
<p class="TableTextSmall1">Card expiration date in MM/YYYY format.</p> 
</td> 
<td> 
<p class="TableTextSmall1">Yes</p> 
</td> 
</tr> 
<tr> 
<td> 
<p class="TableTextSmall1">cvvNumber</p> 
</td> 
<td> 
<p class="TableTextSmall1">Credit card CVV number.</p> 
</td> 
<td> 
<p class="TableTextSmall1">Yes</p> 
</td> 
</tr> 
<tr> 
<td> 
<p class="TableTextSmall1">cardNumber</p> 
</td> 
<td> 
<p class="TableTextSmall1">The credit card number.</p> 
</td> 
<td> 
<p class="TableTextSmall1">Yes</p> 
</td> 
</tr> 
<tr> 
<td> 
<p class="TableTextSmall1">userIdNumber</p> 
</td> 
<td> 
<p class="TableTextSmall1">User's national ID number. Should contain 5-12 digits.</p> 
</td> 
<td> 
<p class="TableTextSmall1">No</p> 
</td> 
</tr> 
</tbody> 
</table>

## removePaymentMethod request

<table>
<colgroup>
<col width="33%" />
<col width="33%" />
<col width="33%" />
</colgroup>
<thead>
<tr class="header">
<th><p>Attribute Name</p></th>
<th><p>Description</p></th>
<th><p>Mandatory</p></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>paymentToken</p></td>
<td><p>A paymentToken is a secure token representing a payment in the Zooz system. You can generate this value any of the following ways:</p>
<ul>
<li>The paymentToken attribute from the openPayment request.</li>
<li>The customerToken attribute from the getToken request.</li>
</ul></td>
<td><p>Yes</p></td>
</tr>
<tr class="even">
<td><p>paymentMethodToken</p></td>
<td><p>The paymentMethodToken to remove.</p></td>
<td><p>Yes</p></td>
</tr>
</tbody>
</table>

## Examples

You can view a complete integration code in the sample app that is part of the SDK zip file.
