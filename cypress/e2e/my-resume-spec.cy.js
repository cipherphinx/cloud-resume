describe('End to End test for my API', () => {
  let visitorCount1, visitorCount2;

  it('Check if visitor_count attribute is available and get its value from the API', () => {
    cy.request('POST','https://api-update-count.arfeldevopsprojects.site')
      .then((response) => {
        expect(response.status).to.eq(200);
        expect(response.body).to.have.property('Attributes');
        expect(response.body.Attributes).to.have.property('visitor_count');

        visitorCount1 = response.body.Attributes.visitor_count.N;
      });

    cy.wait(1000); // wait 1 second

    cy.request('POST','https://api-update-count.arfeldevopsprojects.site')
      .then((response) => {
        expect(response.status).to.eq(200);
        expect(response.body.Attributes).to.have.property('visitor_count');
        visitorCount2 = response.body.Attributes.visitor_count.N;
        
      });
  });

  it('Check if the visitor count is updated every time the API is accessed', () => {
    expect(parseInt(visitorCount2)).to.be.greaterThan(parseInt(visitorCount1));
  });

  it('Checks if the API is accessible via other methods', () => {
    cy.request({
      method: 'GET',
      url: 'https://api-update-count.arfeldevopsprojects.site',
      failOnStatusCode: false,
    }).then((response) => {
      //expect(response.status).to.eq(403);
      expect(response.body).to.have.property('message', 'Missing Authentication Token');
    });

  });

});
