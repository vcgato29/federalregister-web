require File.dirname(__FILE__) + '/../../spec_helper'

module RegulationsDotGov
  describe CommentForm do
    let(:client) { double(:client) }

    #describe "#allow_attachments?" do
      #it "returns true if attachments are allowed" do
        #allow_attachments = true
        #comment_form = RegulationsDotGov::CommentForm.new(client, {'showAttachment' => allow_attachments})
        
        #expect( comment_form.allow_attachments? ).to eq(allow_attachments)
      #end

      #it "returns false if attachments are not allowed" do
        #allow_attachments = false
        #comment_form = RegulationsDotGov::CommentForm.new(client, {'showAttachment' => allow_attachments})
        
        #expect( comment_form.allow_attachments? ).to eq(allow_attachments)
      #end
    #end

    describe "#alternative_ways_to_comment" do
      it "returns the string of text if it is present" do
        text = "Written submissions. Pursuant to section 207.61 of the Commission's rules, each interested party response..."
        comment_form = CommentForm.new(client, {'document' => {'alternateWaysToComment' => text}})

        expect( comment_form.alternative_ways_to_comment ).to eq(text)
      end

      it "returns nil if the string of text is not present" do
        comment_form = CommentForm.new(client, {'document' => {}})

        expect( comment_form.alternative_ways_to_comment ).to eq(nil)
      end
    end

    describe "#submit_by" do
      it "returns a date" do
        end_date = '2013-11-17'
        comment_form = CommentForm.new(client, {'document' => {'commentEndDate' => end_date}})

        expect( comment_form.submit_by ).to eq(DateTime.parse end_date)
      end
    end

    describe "#comments_open_at" do
      it "returns a start date" do
        start_date = '2013-09-02'
        comment_form = CommentForm.new(client, {'document' => {'commentStartDate' => start_date}})

        expect( comment_form.comments_open_at ).to eq(DateTime.parse start_date)
      end
    end

    describe "#comments_close_at" do
      it "returns an end date" do
        end_date = '2013-11-17'
        comment_form = CommentForm.new(client, {'document' => {'commentEndDate' => end_date}})

        expect( comment_form.comments_close_at ).to eq(DateTime.parse end_date)
      end
    end

    describe "#posting_guidelines" do
      it "returns a string" do
        guidelines = 'You should post in a certain way...'
        comment_form = CommentForm.new(client, {'postingGuidelines' => guidelines})

        expect( comment_form.posting_guidelines ).to eq(guidelines)
      end
    end

    describe "#document_id" do
      it "returns the document id" do
        document_id = 'ITC-2013-0207-0001'
        comment_form = CommentForm.new(client, {'document' => {'documentId' => document_id}})

        expect( comment_form.document_id ).to eq(document_id)
      end
    end

    describe "#agency_name" do
      it "returns the agency name" do
        agency_name = 'International Trade Commission'
        comment_form = CommentForm.new(client, {'document' => {'agencyName' => agency_name}})

        expect( comment_form.agency_name ).to eq(agency_name)
      end
    end

    describe "#agency_acronym" do
      it "returns the agency acronym" do
        agency_acronym = 'International Trade Commission'
        comment_form = CommentForm.new(client, {'document' => {'agencyAcronym' => agency_acronym}})

        expect( comment_form.agency_acronym ).to eq(agency_acronym)
      end
    end

    describe "#fields" do
      let(:fields) {
        [
          {"attribute" => "SUBMITTER_FIRST_NAME"},
          {"attribute" => "SUBMITTER_LAST_NAME"}
        ]
      }

      it "calls Field.build with the appropriate arguments" do
        agency_acronym = "ITC"
        comment_form = CommentForm.new(client, {'document' => {'agencyAcronym' => agency_acronym}, 'metadataList' => fields})

        expect( CommentForm::Field ).to receive(:build).with(client, fields.first, comment_form.agency_acronym)
        expect( CommentForm::Field ).to receive(:build).with(client, fields.last, comment_form.agency_acronym)

        comment_form.fields
      end
    end
  end
end